import ManagedSettings
import ManagedSettingsUI
import UIKit

/// The screen iOS shows when someone opens an app this session has put away.
///
/// Screen Time draws the shield itself. This extension only chooses the mark,
/// the words, and the buttons. The filled button closes the blocked app.
///
class FocusShieldConfigurationExtension: ShieldConfigurationDataSource {
  override func configuration(shielding application: Application) -> ShieldConfiguration {
    FocusShieldAppearance.screen
  }

  override func configuration(
    shielding application: Application,
    in category: ActivityCategory
  ) -> ShieldConfiguration {
    FocusShieldAppearance.screen
  }

  override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
    FocusShieldAppearance.screen
  }

  override func configuration(
    shielding webDomain: WebDomain,
    in category: ActivityCategory
  ) -> ShieldConfiguration {
    FocusShieldAppearance.screen
  }
}

private enum FocusShieldAppearance {
  static var screen: ShieldConfiguration {
    ShieldConfiguration(
      backgroundBlurStyle: .systemThickMaterialDark,
      backgroundColor: FoquiShieldColor.canvas,
      icon: UIImage(
        named: "ShieldMark",
        in: Bundle(for: FocusShieldConfigurationExtension.self),
        compatibleWith: nil
      ),
      // A real title is always the large bold style. A blank one keeps this
      // message on the smaller subtitle line.
      title: ShieldConfiguration.Label(text: " ", color: .clear),
      subtitle: ShieldConfiguration.Label(text: ShieldCopy.message, color: FoquiShieldColor.body),
      // iOS draws one filled button and one text button. OK keeps the fill.
      primaryButtonLabel: ShieldConfiguration.Label(text: ShieldCopy.button, color: .white),
      primaryButtonBackgroundColor: FoquiShieldColor.violet,
      secondaryButtonLabel: ShieldConfiguration.Label(text: ShieldCopy.openFoqui, color: FoquiShieldColor.violet)
    )
  }
}

/// Charcoal screen, light type, and the app's violet action.
private enum FoquiShieldColor {
  static let canvas = UIColor(red: 0x1C / 255, green: 0x1C / 255, blue: 0x1E / 255, alpha: 1)
  /// The only size smaller than the system title.
  static let body = UIColor(red: 0xF2 / 255, green: 0xF2 / 255, blue: 0xF7 / 255, alpha: 1)
  static let violet = UIColor(red: 0x81 / 255, green: 0x54 / 255, blue: 0xE8 / 255, alpha: 1)
}

private enum ShieldCopy {
  static var message: String {
    let when: String
    if let endsAt = ShieldSchedule.endsAt, endsAt > Date() {
      when = timed(ShieldSchedule.clockText(endsAt))
    } else {
      when = untilYouFinish
    }
    return "\(blocking) \(when)"
  }

  private static var blocking: String {
    switch language {
    case .spanish:
      return "Foqui está bloqueando esta app durante tu sesión."
    case .german:
      return "Foqui blockiert diese App während deiner Sitzung."
    case .portuguese:
      return "O Foqui está bloqueando este app durante a sua sessão."
    case .french:
      return "Foqui bloque cette app pendant votre session."
    default:
      return "Foqui is blocking this app during your session."
    }
  }

  private static var untilYouFinish: String {
    switch language {
    case .spanish:
      return "Volveré cuando termines."
    case .german:
      return "Ich komme zurück, wenn du fertig bist."
    case .portuguese:
      return "Volto quando você terminar."
    case .french:
      return "Je reviens quand vous terminez."
    default:
      return "I'll come back when you finish."
    }
  }

  static let button = "OK"

  static var openFoqui: String {
    switch language {
    case .spanish:
      return "Ir a Foqui"
    case .german:
      return "Zu Foqui"
    case .portuguese:
      return "Ir para o Foqui"
    case .french:
      return "Aller à Foqui"
    default:
      return "Go to Foqui"
    }
  }

  private static var language: Locale.LanguageCode? {
    Locale.current.language.languageCode
  }

  private static func timed(_ time: String) -> String {
    switch language {
    case .spanish:
      return "Volveré a las \(time)."
    case .german:
      return "Ich komme um \(time) zurück."
    case .portuguese:
      return "Volto às \(time)."
    case .french:
      return "Je reviens à \(time)."
    default:
      return "I'll come back at \(time)."
    }
  }
}

/// Reads the session end the main app stored in the shared App Group.
/// Kept here so this extension does not link Device Activity or Family Controls.
private enum ShieldSchedule {
  static let appGroupId = "group.foqui.theboringbuilders.xyz"
  static let activeEndsKey = "foqui.activeEndsAt"

  static var endsAt: Date? {
    let stored = UserDefaults(suiteName: appGroupId)?.double(forKey: activeEndsKey) ?? 0
    guard stored > 0 else { return nil }
    return Date(timeIntervalSince1970: stored)
  }

  static func clockText(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter.string(from: date)
  }
}
