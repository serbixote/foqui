# Foqui

Foqui runs a focus session and shields a list of apps until the timer ends.

Pick the apps, categories, or websites with the system Screen Time picker, choose a length from 15 minutes to 3 hours, and start. Foqui applies a Screen Time shield immediately. A Device Activity extension removes it when the session ends, including if you have left the app. You can also end a session early.

Blocking uses Family Controls on a physical iPhone. The simulator can open the app, but it cannot shield apps.

## Screen Time setup

Signing needs both targets, `foqui.theboringbuilders.xyz` and `foqui.theboringbuilders.xyz.FocusActivityMonitor`, plus the App Group `group.foqui.theboringbuilders.xyz`.

1. In the Apple Developer portal, register both App IDs.
2. Enable Family Controls and App Groups on each ID, and add `group.foqui.theboringbuilders.xyz` to both.
3. In Xcode, confirm the Runner and FocusActivityMonitor targets use team `PPKD4UG65K` and their entitlements files.

Family Controls for the App Store needs Apple's distribution approval. Development builds work once the capability is on the App ID.
