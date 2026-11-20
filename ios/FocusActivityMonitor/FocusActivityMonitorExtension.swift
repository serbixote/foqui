import DeviceActivity
import Foundation
import os

/// Clears the focus shield when the scheduled interval ends, even if Foqui
/// is not running. `intervalDidStart` also reapplies it if the system starts
/// the interval while the app is suspended.
class FocusActivityMonitorExtension: DeviceActivityMonitor {
  private let logger = Logger(
    subsystem: "com.example.foqui",
    category: "FocusActivityMonitor"
  )

  override func intervalDidStart(for activity: DeviceActivityName) {
    super.intervalDidStart(for: activity)
    guard let listId = FocusShieldStore.activeListId() else {
      FocusShieldStore.clear()
      return
    }
    if let endsAt = FocusShieldStore.activeEndsAt(), endsAt <= Date() {
      logger.notice("interval started after the session ended — clearing shield")
      FocusShieldStore.clear()
      FocusShieldStore.clearActive()
      return
    }
    guard let selection = FocusShieldStore.load(
      forKey: FocusShieldStore.selectionKey(listId)
    ) else {
      FocusShieldStore.clear()
      return
    }
    FocusShieldStore.apply(selection)
    logger.notice("reapplied shield for \(listId, privacy: .public)")
  }

  override func intervalDidEnd(for activity: DeviceActivityName) {
    super.intervalDidEnd(for: activity)
    logger.notice("interval ended — clearing shield")
    FocusShieldStore.clear()
    FocusShieldStore.clearActive()
  }
}
