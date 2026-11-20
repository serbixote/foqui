import DeviceActivity
import FamilyControls
import Foundation
import ManagedSettings

enum FocusShieldError: LocalizedError {
  case emptySelection
  case tooShort
  case appGroupUnavailable

  var errorDescription: String? {
    switch self {
    case .emptySelection:
      return "Choose at least one app to block."
    case .tooShort:
      return "A focus session has to be at least 15 minutes."
    case .appGroupUnavailable:
      return "The Foqui App Group is not available. Enable group.foqui.theboringbuilders.xyz for this target."
    }
  }

  var flutterCode: String {
    switch self {
    case .emptySelection:
      return "EMPTY_SELECTION"
    case .tooShort:
      return "DEVICE_ACTIVITY"
    case .appGroupUnavailable:
      return "UNAVAILABLE"
    }
  }
}

/// Shared by the app and the Device Activity extension.
///
/// App tokens never cross into Dart. They live in the App Group, and the
/// extension clears the shield when the schedule ends — including if Foqui
/// has been closed.
enum FocusShieldStore {
  static let appGroupId = "group.foqui.theboringbuilders.xyz"
  static let activityName = DeviceActivityName("foqui.focus")
  static let storeName = ManagedSettingsStore.Name("foqui.focus")
  static let activeListKey = "foqui.activeListId"
  static let activeEndsKey = "foqui.activeEndsAt"

  /// Device Activity refuses intervals shorter than this.
  static let minimumSchedule: TimeInterval = 15 * 60

  static func selectionKey(_ listId: String) -> String {
    "foqui.selection.\(listId)"
  }

  static func draftKey(_ listId: String) -> String {
    "foqui.selection.draft.\(listId)"
  }

  static func defaults() -> UserDefaults? {
    UserDefaults(suiteName: appGroupId)
  }

  static func save(_ selection: FamilyActivitySelection, forKey key: String) throws {
    guard let defaults = defaults() else {
      throw FocusShieldError.appGroupUnavailable
    }
    let data = try PropertyListEncoder().encode(selection)
    defaults.set(data, forKey: key)
  }

  static func load(forKey key: String) -> FamilyActivitySelection? {
    guard let data = defaults()?.data(forKey: key) else { return nil }
    return try? PropertyListDecoder().decode(FamilyActivitySelection.self, from: data)
  }

  static func loadDraftOrSaved(listId: String) -> FamilyActivitySelection {
    if let draft = load(forKey: draftKey(listId)) {
      return draft
    }
    if let saved = load(forKey: selectionKey(listId)) {
      return saved
    }
    return FamilyActivitySelection()
  }

  static func commitDraft(listId: String) -> FamilyActivitySelection? {
    let defaults = defaults()
    let draft = draftKey(listId)
    if let data = defaults?.data(forKey: draft) {
      defaults?.set(data, forKey: selectionKey(listId))
      defaults?.removeObject(forKey: draft)
    }
    return load(forKey: selectionKey(listId))
  }

  static func discardDraft(listId: String) {
    defaults()?.removeObject(forKey: draftKey(listId))
  }

  static func deleteSelection(listId: String) {
    let defaults = defaults()
    defaults?.removeObject(forKey: selectionKey(listId))
    defaults?.removeObject(forKey: draftKey(listId))
  }

  static func isEmpty(_ selection: FamilyActivitySelection) -> Bool {
    selection.applicationTokens.isEmpty
      && selection.categoryTokens.isEmpty
      && selection.webDomainTokens.isEmpty
  }

  static func counts(_ selection: FamilyActivitySelection) -> [String: Int] {
    [
      "applicationCount": selection.applicationTokens.count,
      "categoryCount": selection.categoryTokens.count,
      "webDomainCount": selection.webDomainTokens.count,
    ]
  }

  static func apply(_ selection: FamilyActivitySelection) {
    let store = ManagedSettingsStore(named: storeName)
    store.shield.applications = selection.applicationTokens.isEmpty
      ? nil
      : selection.applicationTokens
    if selection.categoryTokens.isEmpty {
      store.shield.applicationCategories = nil
      store.shield.webDomainCategories = nil
    } else {
      store.shield.applicationCategories = ShieldSettings
        .ActivityCategoryPolicy<Application>
        .specific(selection.categoryTokens)
      store.shield.webDomainCategories = ShieldSettings
        .ActivityCategoryPolicy<WebDomain>
        .specific(selection.categoryTokens)
    }
    store.shield.webDomains = selection.webDomainTokens.isEmpty
      ? nil
      : selection.webDomainTokens
  }

  static func clear() {
    ManagedSettingsStore(named: storeName).clearAllSettings()
  }

  static func markActive(listId: String, endsAt: Date?) {
    let defaults = defaults()
    defaults?.set(listId, forKey: activeListKey)
    if let endsAt {
      defaults?.set(endsAt.timeIntervalSince1970, forKey: activeEndsKey)
    } else {
      defaults?.removeObject(forKey: activeEndsKey)
    }
  }

  static func clearActive() {
    let defaults = defaults()
    defaults?.removeObject(forKey: activeListKey)
    defaults?.removeObject(forKey: activeEndsKey)
  }

  static func activeListId() -> String? {
    defaults()?.string(forKey: activeListKey)
  }

  static func activeEndsAt() -> Date? {
    let stored = defaults()?.double(forKey: activeEndsKey) ?? 0
    guard stored > 0 else { return nil }
    return Date(timeIntervalSince1970: stored)
  }

  static func schedule(until end: Date) throws {
    let calendar = Calendar.current
    let start = Date().addingTimeInterval(-1)
    let activitySchedule = DeviceActivitySchedule(
      intervalStart: calendar.dateComponents([.hour, .minute, .second], from: start),
      intervalEnd: calendar.dateComponents([.hour, .minute, .second], from: end),
      repeats: false
    )
    let center = DeviceActivityCenter()
    center.stopMonitoring([activityName])
    try center.startMonitoring(activityName, during: activitySchedule)
  }

  static func beginSession(listId: String, endsAt: Date?, strict: Bool) throws {
    guard defaults() != nil else {
      throw FocusShieldError.appGroupUnavailable
    }
    guard let selection = load(forKey: selectionKey(listId)), !isEmpty(selection) else {
      throw FocusShieldError.emptySelection
    }
    apply(selection)
    markActive(listId: listId, endsAt: endsAt)

    guard let endsAt else {
      DeviceActivityCenter().stopMonitoring([activityName])
      return
    }

    let remaining = endsAt.timeIntervalSinceNow
    guard remaining >= minimumSchedule else {
      if strict {
        clear()
        clearActive()
        throw FocusShieldError.tooShort
      }
      return
    }

    do {
      try schedule(until: endsAt)
    } catch {
      if strict {
        clear()
        clearActive()
        throw error
      }
      apply(selection)
    }
  }

  static func endSession() {
    DeviceActivityCenter().stopMonitoring([activityName])
    clear()
    clearActive()
  }
}
