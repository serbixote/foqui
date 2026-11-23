package com.example.foqui

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.content.pm.PackageManager
import android.os.SystemClock
import android.provider.Settings
import android.view.accessibility.AccessibilityEvent

/**
 * Notices when a blocked app comes to the front and covers it with [ShieldActivity].
 *
 * The event only supplies the app's package name. The service does not read
 * the contents of the screen.
 */
class FocusAccessibilityService : AccessibilityService() {
    private var lastPackage = ""
    private var lastAt = 0L

    override fun onServiceConnected() {
        super.onServiceConnected()
        instance = this
        if (FocusBlockStore.get(this).clearIfExpired()) {
            ShieldActivity.dismiss()
        }
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return
        if (event.eventType != AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) return
        val packageName = event.packageName?.toString() ?: return
        maybeShield(packageName)
    }

    override fun onInterrupt() {}

    override fun onDestroy() {
        if (instance == this) instance = null
        super.onDestroy()
    }

    private fun maybeShield(packageName: String) {
        if (AppPickerActivity.isOpen) return
        if (SystemClock.uptimeMillis() < ShieldActivity.suppressUntil) return
        val now = SystemClock.uptimeMillis()
        if (packageName == lastPackage && now - lastAt < 400L && ShieldActivity.isCovering) return
        lastPackage = packageName
        lastAt = now

        val store = FocusBlockStore.get(this)
        if (store.clearIfExpired()) {
            ShieldActivity.dismiss()
            return
        }
        if (!shouldBlock(packageName, store)) return
        if (ShieldActivity.isCovering) return
        ShieldActivity.isCovering = true
        val intent = Intent(this, ShieldActivity::class.java).apply {
            addFlags(
                Intent.FLAG_ACTIVITY_NEW_TASK or
                    Intent.FLAG_ACTIVITY_SINGLE_TOP or
                    Intent.FLAG_ACTIVITY_CLEAR_TOP or
                    Intent.FLAG_ACTIVITY_NO_ANIMATION,
            )
        }
        try {
            startActivity(intent)
        } catch (_: RuntimeException) {
            ShieldActivity.isCovering = false
        }
    }

    private fun shouldBlock(packageName: String, store: FocusBlockStore): Boolean {
        if (packageName.isEmpty() || packageName == this.packageName) return false
        if (packageName in allowedPackages()) return false
        return packageName in store.activePackages()
    }

    private fun allowedPackages(): Set<String> {
        val allowed = mutableSetOf(
            "android",
            "com.android.systemui",
            "com.android.settings",
            "com.android.permissioncontroller",
            "com.google.android.permissioncontroller",
            "com.android.intentresolver",
        )
        val home = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_HOME)
        val homes = packageManager.queryIntentActivities(home, PackageManager.MATCH_DEFAULT_ONLY)
        for (info in homes) {
            allowed.add(info.activityInfo.packageName)
        }
        val ime = Settings.Secure.getString(contentResolver, Settings.Secure.DEFAULT_INPUT_METHOD)
        val imePackage = ime?.substringBefore('/')
        if (!imePackage.isNullOrEmpty()) allowed.add(imePackage)
        return allowed
    }

    companion object {
        private var instance: FocusAccessibilityService? = null
    }
}
