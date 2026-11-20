import FamilyControls
import Flutter
import ManagedSettings
import os
import SwiftUI
import UIKit

/// Family Controls bridge for Foqui focus sessions.
final class FocusShieldPlugin: NSObject, FlutterPlugin {
  static let channelName = "foqui/focus_shield"

  private let logger = Logger(subsystem: "com.example.foqui", category: "FocusShield")
  private var presentationDelegate: PickerDismissDelegate?
  private var pendingResult: FlutterResult?
  private var pickerFinished = false
  @MainActor private static var authorizationRequest: Task<String, Error>?

  static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: channelName,
      binaryMessenger: registrar.messenger()
    )
    let instance = FocusShieldPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "familyControlsStatus":
      Task { @MainActor in
        result(await Self.resolvedAuthorizationStatus())
      }
    case "requestFamilyControlsAuthorization":
      Task { @MainActor in
        do {
          let status = try await Self.requestAuthorization()
          result(status)
        } catch {
          self.logger.error("authorization failed: \(error.localizedDescription, privacy: .public)")
          result(
            FlutterError(
              code: "FAMILY_CONTROLS",
              message: error.localizedDescription,
              details: nil
            )
          )
        }
      }
    case "openSystemSettings":
      guard let url = URL(string: UIApplication.openSettingsURLString) else {
        result(false)
        return
      }
      UIApplication.shared.open(url, options: [:]) { opened in
        result(opened)
      }
    case "presentAppPicker":
      guard let listId = stringArgument(call, key: "listId") else {
        result(FlutterError(code: "BAD_ARGS", message: "Missing list id.", details: nil))
        return
      }
      Task { @MainActor in
        self.presentPicker(listId: listId, result: result)
      }
    case "commitSelection":
      guard let listId = stringArgument(call, key: "listId") else {
        result(FlutterError(code: "BAD_ARGS", message: "Missing list id.", details: nil))
        return
      }
      Task { @MainActor in
        guard let selection = FocusShieldStore.commitDraft(listId: listId) else {
          result(nil)
          return
        }
        result(await selectionPayload(selection))
      }
    case "applicationNames":
      let listIds = stringListArgument(call, key: "listIds")
      Task { @MainActor in
        var payload: [String: [String]] = [:]
        for listId in listIds {
          guard let selection = FocusShieldStore.load(forKey: FocusShieldStore.selectionKey(listId)) else {
            continue
          }
          let names = await ApplicationNameReader.names(for: selection)
          if !names.isEmpty {
            payload[listId] = names
          }
        }
        result(payload)
      }
    case "storedSelections":
      let listIds = stringListArgument(call, key: "listIds")
      Task { @MainActor in
        var payload: [String: [String: Int]] = [:]
        for listId in listIds {
          guard let selection = FocusShieldStore.load(forKey: FocusShieldStore.selectionKey(listId)),
                !FocusShieldStore.isEmpty(selection) else {
            continue
          }
          payload[listId] = FocusShieldStore.counts(selection)
        }
        result(payload)
      }
    case "discardDraft":
      guard let listId = stringArgument(call, key: "listId") else {
        result(FlutterError(code: "BAD_ARGS", message: "Missing list id.", details: nil))
        return
      }
      FocusShieldStore.discardDraft(listId: listId)
      result(nil)
    case "deleteSelection":
      guard let listId = stringArgument(call, key: "listId") else {
        result(FlutterError(code: "BAD_ARGS", message: "Missing list id.", details: nil))
        return
      }
      FocusShieldStore.deleteSelection(listId: listId)
      result(nil)
    case "startSession":
      guard
        let args = call.arguments as? [String: Any],
        let listId = args["listId"] as? String,
        !listId.isEmpty
      else {
        result(FlutterError(code: "BAD_ARGS", message: "Missing session details.", details: nil))
        return
      }
      let strict = boolValue(args["strict"], default: true)
      let endsAt: Date?
      if let endsAtMillis = integer(args["endsAtMillis"]), endsAtMillis > 0 {
        endsAt = Date(timeIntervalSince1970: TimeInterval(endsAtMillis) / 1000)
      } else {
        endsAt = nil
      }
      Task { @MainActor in
        let status = Self.authorizationStatus()
        guard status == "approved" else {
          result(
            FlutterError(
              code: status == "unavailable" ? "UNAVAILABLE" : "NOT_AUTHORIZED",
              message: nil,
              details: nil
            )
          )
          return
        }
        do {
          try FocusShieldStore.beginSession(listId: listId, endsAt: endsAt, strict: strict)
          result(nil)
        } catch let error as FocusShieldError {
          result(
            FlutterError(
              code: error.flutterCode,
              message: error.localizedDescription,
              details: nil
            )
          )
        } catch {
          self.logger.error("startSession failed: \(error.localizedDescription, privacy: .public)")
          result(
            FlutterError(
              code: "DEVICE_ACTIVITY",
              message: error.localizedDescription,
              details: nil
            )
          )
        }
      }
    case "stopSession":
      Task { @MainActor in
        FocusShieldStore.endSession()
        result(nil)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  @MainActor
  private func presentPicker(listId: String, result: @escaping FlutterResult) {
    if pendingResult != nil {
      result(FlutterError(code: "BUSY", message: "The app picker is already open.", details: nil))
      return
    }
    guard #available(iOS 16.0, *) else {
      result(FlutterError(code: "UNAVAILABLE", message: nil, details: nil))
      return
    }
    let status = Self.authorizationStatus()
    guard status == "approved" else {
      result(
        FlutterError(
          code: status == "unavailable" ? "UNAVAILABLE" : "NOT_AUTHORIZED",
          message: nil,
          details: nil
        )
      )
      return
    }
    guard let presenter = topViewController() else {
      result(FlutterError(code: "NO_PRESENTER", message: nil, details: nil))
      return
    }

    pickerFinished = false
    pendingResult = result
    let selection = FocusShieldStore.loadDraftOrSaved(listId: listId)
    let delegate = PickerDismissDelegate { [weak self] in
      self?.finishPicker(nil)
    }
    presentationDelegate = delegate

    let view = AppPickerView(
      selection: selection,
      onCancel: { [weak self] in
        Task { @MainActor in
          await self?.dismissPicker(saving: nil)
        }
      },
      onDone: { [weak self] picked in
        Task { @MainActor in
          await self?.dismissPicker(saving: picked, listId: listId)
        }
      }
    )
    let host = UIHostingController(rootView: view)
    host.modalPresentationStyle = .pageSheet
    host.presentationController?.delegate = delegate
    host.sheetPresentationController?.prefersGrabberVisible = true
    presenter.present(host, animated: true)
  }

  @MainActor
  private func dismissPicker(saving selection: FamilyActivitySelection?, listId: String? = nil) async {
    if let selection, let listId {
      do {
        try FocusShieldStore.save(selection, forKey: FocusShieldStore.draftKey(listId))
        let payload = await selectionPayload(selection)
        topViewController()?.dismiss(animated: true) {
          self.finishPicker(payload)
        }
      } catch {
        topViewController()?.dismiss(animated: true) {
          self.finishPicker(
            FlutterError(code: "DEVICE_ACTIVITY", message: error.localizedDescription, details: nil)
          )
        }
      }
      return
    }
    topViewController()?.dismiss(animated: true) {
      self.finishPicker(nil)
    }
  }

  @MainActor
  private func selectionPayload(_ selection: FamilyActivitySelection) async -> [String: Any] {
    var payload: [String: Any] = [:]
    for (key, value) in FocusShieldStore.counts(selection) {
      payload[key] = value
    }
    let names = await ApplicationNameReader.names(for: selection)
    if !names.isEmpty {
      payload["applicationNames"] = names
    }
    return payload
  }

  private func finishPicker(_ value: Any?) {
    guard !pickerFinished else { return }
    pickerFinished = true
    let callback = pendingResult
    pendingResult = nil
    presentationDelegate = nil
    callback?(value)
  }

  /// `authorizationStatus` is `.notDetermined` on every cold start until
  /// `requestAuthorization` runs. A later call does not show the system alert
  /// when Screen Time is already allowed — it only publishes `.approved`.
  /// Reading the property alone makes the home banner return after each launch
  /// and each reinstall, even though Settings still shows access as granted.
  @MainActor
  private static func resolvedAuthorizationStatus() async -> String {
    guard #available(iOS 16.0, *) else { return "unavailable" }
    switch authorizationStatus() {
    case "approved":
      ScreenTimeGrant.remember(approved: true)
      return "approved"
    case "denied":
      ScreenTimeGrant.remember(approved: false)
      return "denied"
    case "notDetermined":
      break
    default:
      return authorizationStatus()
    }

    // Ask once per install so an existing grant is picked up, and again on
    // later launches only after a grant was recorded. People who have not
    // allowed Screen Time keep the in-app banner instead of a prompt on
    // every open.
    let shouldConfirm = ScreenTimeGrant.approved || !ScreenTimeGrant.checked
    guard shouldConfirm else { return "notDetermined" }

    do {
      return try await requestAuthorization()
    } catch {
      return authorizationStatus()
    }
  }

  @MainActor
  private static func authorizationStatus() -> String {
    guard #available(iOS 16.0, *) else { return "unavailable" }
    return mappedAuthorizationStatus(AuthorizationCenter.shared.authorizationStatus)
  }

  /// `.approvedWithDataAccess` is still Screen Time access. Treating it as
  /// unknown puts the banner back up on iOS 26 even after the user allowed it.
  @available(iOS 16.0, *)
  private static func mappedAuthorizationStatus(_ status: AuthorizationStatus) -> String {
    if #available(iOS 26.4, *) {
      switch status {
      case .approved, .approvedWithDataAccess:
        return "approved"
      case .denied:
        return "denied"
      case .notDetermined:
        return "notDetermined"
      @unknown default:
        return "unknown"
      }
    }
    switch status {
    case .approved:
      return "approved"
    case .denied:
      return "denied"
    case .notDetermined:
      return "notDetermined"
    @unknown default:
      return "unknown"
    }
  }

  @MainActor
  private static func requestAuthorization() async throws -> String {
    if let authorizationRequest {
      return try await authorizationRequest.value
    }
    let request = Task { @MainActor in
      try await performAuthorizationRequest()
    }
    authorizationRequest = request
    do {
      let status = try await request.value
      authorizationRequest = nil
      return status
    } catch {
      authorizationRequest = nil
      throw error
    }
  }

  @MainActor
  private static func performAuthorizationRequest() async throws -> String {
    guard #available(iOS 16.0, *) else { return "unavailable" }
    switch authorizationStatus() {
    case "approved":
      ScreenTimeGrant.remember(approved: true)
      return "approved"
    case "denied":
      ScreenTimeGrant.remember(approved: false)
      return "denied"
    case "notDetermined":
      do {
        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
      } catch {
        let status = await settledAuthorizationStatus()
        if status == "approved" {
          ScreenTimeGrant.remember(approved: true)
          return status
        }
        if status == "denied" || isAuthorizationCancellation(error) {
          ScreenTimeGrant.remember(approved: false)
        }
        throw error
      }
      let status = await settledAuthorizationStatus()
      switch status {
      case "approved":
        ScreenTimeGrant.remember(approved: true)
      case "denied":
        ScreenTimeGrant.remember(approved: false)
      default:
        ScreenTimeGrant.checked = true
      }
      return status
    default:
      return authorizationStatus()
    }
  }

  @MainActor
  private static func settledAuthorizationStatus() async -> String {
    var status = authorizationStatus()
    if status != "notDetermined" { return status }
    for _ in 0..<10 {
      try? await Task.sleep(nanoseconds: 100_000_000)
      status = authorizationStatus()
      if status != "notDetermined" { return status }
    }
    return status
  }

  private static func isAuthorizationCancellation(_ error: Error) -> Bool {
    guard let controlsError = error as? FamilyControlsError else { return false }
    if case .authorizationCanceled = controlsError { return true }
    return false
  }

  private func topViewController() -> UIViewController? {
    let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
    let window = scenes.flatMap(\.windows).first { $0.isKeyWindow } ?? scenes.flatMap(\.windows).first
    var top = window?.rootViewController
    while let presented = top?.presentedViewController {
      top = presented
    }
    return top
  }
}

/// Remembers a Screen Time grant across launches. The system wipes this on
/// reinstall, which is when Foqui asks once more so a grant that survived
/// in Settings can be published again without leaving the banner up.
private enum ScreenTimeGrant {
  static let approvedKey = "foqui.familyControls.approved"
  static let checkedKey = "foqui.familyControls.checkedExistingGrant"

  static var approved: Bool {
    UserDefaults.standard.bool(forKey: approvedKey)
  }

  static var checked: Bool {
    get { UserDefaults.standard.bool(forKey: checkedKey) }
    set { UserDefaults.standard.set(newValue, forKey: checkedKey) }
  }

  static func remember(approved: Bool) {
    UserDefaults.standard.set(approved, forKey: approvedKey)
    checked = true
  }
}

private func stringArgument(_ call: FlutterMethodCall, key: String) -> String? {
  guard let args = call.arguments as? [String: Any],
        let value = args[key] as? String,
        !value.isEmpty
  else {
    return nil
  }
  return value
}

private func stringListArgument(_ call: FlutterMethodCall, key: String) -> [String] {
  guard let args = call.arguments as? [String: Any] else { return [] }
  if let values = args[key] as? [String] {
    return values.filter { !$0.isEmpty }
  }
  guard let values = args[key] as? [Any] else { return [] }
  return values.compactMap { value in
    guard let text = value as? String, !text.isEmpty else { return nil }
    return text
  }
}

private func integer(_ value: Any?) -> Int? {
  switch value {
  case let number as Int:
    return number
  case let number as NSNumber:
    return number.intValue
  default:
    return nil
  }
}

private func boolValue(_ value: Any?, default defaultValue: Bool) -> Bool {
  switch value {
  case let flag as Bool:
    return flag
  case let number as NSNumber:
    return number.boolValue
  default:
    return defaultValue
  }
}

private struct AppPickerView: View {
  @State private var selection: FamilyActivitySelection
  let onCancel: () -> Void
  let onDone: (FamilyActivitySelection) -> Void

  init(
    selection: FamilyActivitySelection,
    onCancel: @escaping () -> Void,
    onDone: @escaping (FamilyActivitySelection) -> Void
  ) {
    _selection = State(initialValue: selection)
    self.onCancel = onCancel
    self.onDone = onDone
  }

  var body: some View {
    NavigationStack {
      FamilyActivityPicker(selection: $selection)
        .ignoresSafeArea()
        .navigationTitle("Choose apps")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", action: onCancel)
          }
          ToolbarItem(placement: .confirmationAction) {
            Button("Done") { onDone(selection) }
          }
        }
    }
  }
}

/// Reads the app names Screen Time stored for a selection.
///
/// Tokens are opaque, so this tries the public display name first and then
/// the title the system draws for `Label`.
@MainActor
private enum ApplicationNameReader {
  static func names(for selection: FamilyActivitySelection) async -> [String] {
    var names = directNames(in: selection)
    if names.count < selection.applicationTokens.count {
      let rendered = await renderedNames(for: Array(selection.applicationTokens))
      for name in rendered where !names.contains(name) {
        names.append(name)
      }
    }
    return names.sorted { $0.localizedCaseInsensitiveCompare($1) == .orderedAscending }
  }

  private static func directNames(in selection: FamilyActivitySelection) -> [String] {
    var names: [String] = []
    func add(_ raw: String?) {
      guard let name = sanitize(raw), !names.contains(name) else { return }
      names.append(name)
    }
    for application in selection.applications {
      add(application.localizedDisplayName)
    }
    for token in selection.applicationTokens {
      add(Application(token: token).localizedDisplayName)
    }
    return names
  }

  private static func renderedNames(for tokens: [ApplicationToken]) async -> [String] {
    guard !tokens.isEmpty, let window = keyWindow() else { return [] }
    let hosts: [UIHostingController<AnyView>] = tokens.map { token in
      let controller = UIHostingController(
        rootView: AnyView(
          Label(token)
            .labelStyle(.titleOnly)
            .lineLimit(1)
            .frame(width: 280, height: 32, alignment: .leading)
        )
      )
      controller.view.backgroundColor = .clear
      controller.view.isUserInteractionEnabled = false
      controller.view.frame = CGRect(x: 0, y: 0, width: 280, height: 32)
      if #available(iOS 16.4, *) {
        controller.safeAreaRegions = []
      }
      return controller
    }

    let stack = UIStackView()
    stack.axis = .vertical
    stack.isUserInteractionEnabled = false
    stack.frame = CGRect(x: -4000, y: -4000, width: 280, height: CGFloat(hosts.count) * 32)
    for host in hosts {
      stack.addArrangedSubview(host.view)
    }
    window.addSubview(stack)
    stack.layoutIfNeeded()
    for host in hosts {
      let bounds = host.view.bounds
      guard bounds.width > 0, bounds.height > 0 else { continue }
      UIGraphicsBeginImageContextWithOptions(bounds.size, false, 1)
      host.view.drawHierarchy(in: bounds, afterScreenUpdates: true)
      UIGraphicsEndImageContext()
    }
    try? await Task.sleep(nanoseconds: 50_000_000)

    var names: [String] = []
    for host in hosts {
      if let name = sanitize(firstText(in: host.view)), !names.contains(name) {
        names.append(name)
      }
    }
    stack.removeFromSuperview()
    return names
  }

  private static func firstText(in view: UIView) -> String? {
    if let label = view as? UILabel {
      let text = label.text ?? label.attributedText?.string
      if let cleaned = sanitize(text) { return cleaned }
    }
    for subview in view.subviews {
      if let text = firstText(in: subview) { return text }
    }
    return sanitize(view.accessibilityLabel)
  }

  private static func sanitize(_ raw: String?) -> String? {
    guard var text = raw?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
      return nil
    }
    for suffix in [", Application", ", App"] where text.hasSuffix(suffix) {
      text = String(text.dropLast(suffix.count)).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    if text.isEmpty || text == "Application" || text == "Label" { return nil }
    return text
  }

  private static func keyWindow() -> UIWindow? {
    let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
    return scenes.flatMap(\.windows).first { $0.isKeyWindow } ?? scenes.flatMap(\.windows).first
  }
}

private final class PickerDismissDelegate: NSObject, UIAdaptivePresentationControllerDelegate {
  let onDismiss: () -> Void

  init(onDismiss: @escaping () -> Void) {
    self.onDismiss = onDismiss
  }

  func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
    onDismiss()
  }
}
