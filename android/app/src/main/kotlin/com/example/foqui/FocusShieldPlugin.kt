package com.example.foqui

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.provider.Settings
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.lang.ref.WeakReference

/**
 * Android side of `foqui/focus_shield`.
 *
 * The same calls the iPhone uses for Screen Time start and stop the block here.
 * Choosing apps stores package names on this phone. The accessibility service
 * shows the shield when one of those apps opens.
 */
class FocusShieldPlugin private constructor(
    context: Context,
    activity: Activity,
) : MethodChannel.MethodCallHandler {
    private val appContext = context.applicationContext
    private val activityRef = WeakReference(activity)
    private val store = FocusBlockStore.get(appContext)

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "familyControlsStatus" -> result.success(store.status(appContext))
            "requestFamilyControlsAuthorization" -> requestAuthorization(result)
            "openSystemSettings" -> {
                store.markPrompted()
                result.success(openAccessibilitySettings())
            }
            "presentAppPicker" -> presentPicker(call, result)
            "commitSelection" -> {
                val listId = stringArg(call, "listId")
                if (listId == null) {
                    result.error("BAD_ARGS", "Missing list id.", null)
                    return
                }
                val saved = store.commit(listId)
                result.success(saved?.let(store::counts))
            }
            "applicationNames" -> result.success(namesFor(stringList(call, "listIds")))
            "storedSelections" -> result.success(storedFor(stringList(call, "listIds")))
            "discardDraft" -> {
                val listId = stringArg(call, "listId")
                if (listId == null) {
                    result.error("BAD_ARGS", "Missing list id.", null)
                    return
                }
                store.discardDraft(listId)
                result.success(null)
            }
            "deleteSelection" -> {
                val listId = stringArg(call, "listId")
                if (listId == null) {
                    result.error("BAD_ARGS", "Missing list id.", null)
                    return
                }
                store.delete(listId)
                result.success(null)
            }
            "startSession" -> startSession(call, result)
            "stopSession" -> {
                store.clearActive()
                ShieldActivity.dismiss()
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun requestAuthorization(result: MethodChannel.Result) {
        if (FocusBlockStore.isServiceEnabled(appContext)) {
            result.success("approved")
            return
        }
        // Already asked once. Later taps use Open Settings, same as iOS after a denial.
        if (store.status(appContext) == "denied") {
            result.success("denied")
            return
        }
        store.markPrompted()
        openAccessibilitySettings()
        result.success("notDetermined")
    }

    private fun presentPicker(call: MethodCall, result: MethodChannel.Result) {
        val listId = stringArg(call, "listId")
        if (listId == null) {
            result.error("BAD_ARGS", "Missing list id.", null)
            return
        }
        if (!FocusBlockStore.isServiceEnabled(appContext)) {
            result.error("NOT_AUTHORIZED", null, null)
            return
        }
        val activity = activityRef.get()
        if (activity == null || activity.isFinishing) {
            result.error("NO_PRESENTER", null, null)
            return
        }
        if (pendingResult != null) {
            result.error("BUSY", "The app picker is already open.", null)
            return
        }
        pendingResult = result
        val intent = Intent(activity, AppPickerActivity::class.java)
        intent.putExtra(AppPickerActivity.EXTRA_LIST_ID, listId)
        activity.startActivity(intent)
    }

    private fun startSession(call: MethodCall, result: MethodChannel.Result) {
        val listId = stringArg(call, "listId")
        if (listId == null) {
            result.error("BAD_ARGS", "Missing session details.", null)
            return
        }
        if (!FocusBlockStore.isServiceEnabled(appContext)) {
            result.error("NOT_AUTHORIZED", null, null)
            return
        }
        val strict = call.argument<Boolean>("strict") ?: true
        val endsAt = longArg(call, "endsAtMillis")?.takeIf { it > 0L }
        try {
            store.begin(listId, endsAt, strict)
            result.success(null)
        } catch (error: BlockerException) {
            result.error(error.code, error.message, null)
        }
    }

    private fun namesFor(listIds: List<String>): Map<String, List<String>> {
        val names = linkedMapOf<String, List<String>>()
        for (listId in listIds) {
            val labels = store.loadSelection(listId).map { it.label }.filter { it.isNotEmpty() }
            if (labels.isNotEmpty()) names[listId] = labels
        }
        return names
    }

    private fun storedFor(listIds: List<String>): Map<String, Map<String, Int>> {
        val stored = linkedMapOf<String, Map<String, Int>>()
        for (listId in listIds) {
            val apps = store.loadSelection(listId)
            if (apps.isEmpty()) continue
            stored[listId] = mapOf(
                "applicationCount" to apps.size,
                "categoryCount" to 0,
                "webDomainCount" to 0,
            )
        }
        return stored
    }

    private fun openAccessibilitySettings(): Boolean {
        val activity = activityRef.get()
        val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
        return try {
            if (activity != null && !activity.isFinishing) {
                activity.startActivity(intent)
            } else {
                intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                appContext.startActivity(intent)
            }
            true
        } catch (_: RuntimeException) {
            false
        }
    }

    companion object {
        private const val CHANNEL = "foqui/focus_shield"
        private var channel: MethodChannel? = null
        private var pendingResult: MethodChannel.Result? = null

        fun register(messenger: BinaryMessenger, activity: Activity) {
            channel?.setMethodCallHandler(null)
            val next = MethodChannel(messenger, CHANNEL)
            next.setMethodCallHandler(FocusShieldPlugin(activity, activity))
            channel = next
        }

        fun detach() {
            channel?.setMethodCallHandler(null)
            channel = null
            finishPicker(null)
        }

        fun finishPicker(value: Any?) {
            val pending = pendingResult ?: return
            pendingResult = null
            pending.success(value)
        }
    }
}

private fun stringArg(call: MethodCall, key: String): String? {
    val value = call.argument<String>(key)
    if (value.isNullOrEmpty()) return null
    return value
}

private fun stringList(call: MethodCall, key: String): List<String> {
    val raw = call.argument<List<*>>(key) ?: return emptyList()
    return raw.mapNotNull { it as? String }.filter { it.isNotEmpty() }
}

private fun longArg(call: MethodCall, key: String): Long? {
    return when (val value = call.argument<Any>(key)) {
        is Int -> value.toLong()
        is Long -> value
        is Double -> value.toLong()
        else -> null
    }
}
