# Foqui

Foqui runs a focus session and shields a list of apps until the timer ends.

Pick the apps, categories, or websites with the system Screen Time picker, choose a length from 15 minutes to 3 hours, and start. Foqui applies a Screen Time shield immediately. Opening a blocked app shows Foqui's own screen, with the time the session gives that app back. A Device Activity extension removes the shield when the session ends, including if you have left the app. You can also end a session early.

Blocking uses Family Controls on a physical iPhone. The simulator can open the app, but it cannot shield apps.

## Screen Time setup

Signing needs the app and its extensions: `foqui.theboringbuilders.xyz`, `foqui.theboringbuilders.xyz.FocusActivityMonitor`, `foqui.theboringbuilders.xyz.FocusShieldConfiguration`, and `foqui.theboringbuilders.xyz.FocusShieldAction`, plus the App Group `group.foqui.theboringbuilders.xyz`.

1. In the Apple Developer portal, register all four App IDs.
2. Enable Family Controls on each ID. Enable App Groups on the app, the monitor, and the shield configuration, and add `group.foqui.theboringbuilders.xyz` to those three.
3. In Xcode, confirm the Runner, FocusActivityMonitor, FocusShieldConfiguration, and FocusShieldAction targets use team `PPKD4UG65K` and their entitlements files.

Family Controls for the App Store needs Apple's distribution approval. Development builds work once the capability is on the App ID.
