import ManagedSettings

/// Handles the buttons on the blocked-app screen.
///
/// OK closes the blocked app. Go to Foqui opens this app.
class FocusShieldActionExtension: ShieldActionDelegate {
  override func handle(
    action: ShieldAction,
    for application: ApplicationToken,
    completionHandler: @escaping (ShieldActionResponse) -> Void
  ) {
    respond(to: action, completionHandler: completionHandler)
  }

  override func handle(
    action: ShieldAction,
    for category: ActivityCategoryToken,
    completionHandler: @escaping (ShieldActionResponse) -> Void
  ) {
    respond(to: action, completionHandler: completionHandler)
  }

  override func handle(
    action: ShieldAction,
    for webDomain: WebDomainToken,
    completionHandler: @escaping (ShieldActionResponse) -> Void
  ) {
    respond(to: action, completionHandler: completionHandler)
  }

  private func respond(
    to action: ShieldAction,
    completionHandler: @escaping (ShieldActionResponse) -> Void
  ) {
    guard action == .secondaryButtonPressed else {
      completionHandler(.close)
      return
    }
    if #available(iOS 26.5, *) {
      completionHandler(.openParentalControlsApp)
    } else {
      completionHandler(.close)
    }
  }
}
