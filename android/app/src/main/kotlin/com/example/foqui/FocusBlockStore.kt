package com.example.foqui

import android.content.ComponentName
import android.content.Context
import android.content.SharedPreferences
import android.provider.Settings
import android.text.TextUtils
import org.json.JSONArray
import org.json.JSONObject

data class BlockedApp(val packageName: String, val label: String)

class BlockerException(val code: String, message: String) : Exception(message)

/**
 * Apps chosen on this phone, and the session that is blocking them now.
 *
 * Package names stay on the device. The accessibility service reads the
 * active set even after the Flutter UI has gone.
 */
class FocusBlockStore private constructor(
    private val prefs: SharedPreferences,
) {
    fun status(context: Context): String {
        if (isServiceEnabled(context)) return "approved"
        if (prefs.getBoolean(PROMPTED, false)) return "denied"
        return "notDetermined"
    }

    fun markPrompted() {
        prefs.edit().putBoolean(PROMPTED, true).apply()
    }

    fun loadSelection(listId: String): List<BlockedApp> = load(selectionKey(listId))

    fun loadDraftOrSaved(listId: String): List<BlockedApp> {
        if (prefs.contains(draftKey(listId))) return load(draftKey(listId))
        return load(selectionKey(listId))
    }

    fun saveDraft(listId: String, apps: List<BlockedApp>) {
        prefs.edit().putString(draftKey(listId), encode(apps)).apply()
    }

    fun commit(listId: String): List<BlockedApp>? {
        val draft = draftKey(listId)
        val saved = selectionKey(listId)
        val editor = prefs.edit()
        if (prefs.contains(draft)) {
            val raw = prefs.getString(draft, null)
            if (raw == null) editor.remove(saved) else editor.putString(saved, raw)
            editor.remove(draft)
        }
        editor.commit()
        if (!prefs.contains(saved)) return null
        return load(saved)
    }

    fun discardDraft(listId: String) {
        prefs.edit().remove(draftKey(listId)).apply()
    }

    fun delete(listId: String) {
        prefs.edit().remove(selectionKey(listId)).remove(draftKey(listId)).apply()
    }

    fun counts(apps: List<BlockedApp>): Map<String, Any> {
        return mapOf(
            "applicationCount" to apps.size,
            "categoryCount" to 0,
            "webDomainCount" to 0,
            "applicationNames" to apps.map { it.label },
        )
    }

    /**
     * Arms the block for [listId]. A null [endsAtMillis] stays up until the
     * session is stopped. [strict] rejects a timer shorter than 15 minutes.
     */
    fun begin(listId: String, endsAtMillis: Long?, strict: Boolean) {
        synchronized(lock) {
            val apps = load(selectionKey(listId))
            if (apps.isEmpty()) {
                throw BlockerException("EMPTY_SELECTION", "Choose at least one app to block.")
            }
            val ends = endsAtMillis ?: 0L
            if (ends > 0L && strict && ends - System.currentTimeMillis() < MINIMUM_MS) {
                throw BlockerException(
                    "DEVICE_ACTIVITY",
                    "A focus session has to be at least 15 minutes.",
                )
            }
            val packages = JSONArray()
            for (app in apps) packages.put(app.packageName)
            prefs.edit()
                .putString(ACTIVE_PACKAGES, packages.toString())
                .putString(ACTIVE_LIST, listId)
                .putLong(ACTIVE_ENDS, ends)
                .commit()
        }
    }

    fun clearActive() {
        synchronized(lock) {
            prefs.edit()
                .remove(ACTIVE_PACKAGES)
                .remove(ACTIVE_LIST)
                .remove(ACTIVE_ENDS)
                .commit()
        }
    }

    /** Clears the block when the timer has already run out. */
    fun clearIfExpired(): Boolean {
        synchronized(lock) {
            val ends = prefs.getLong(ACTIVE_ENDS, 0L)
            if (ends <= 0L || System.currentTimeMillis() < ends) return false
            prefs.edit()
                .remove(ACTIVE_PACKAGES)
                .remove(ACTIVE_LIST)
                .remove(ACTIVE_ENDS)
                .commit()
            return true
        }
    }

    fun endsAtMillis(): Long = prefs.getLong(ACTIVE_ENDS, 0L)

    fun activePackages(): Set<String> {
        if (clearIfExpired()) return emptySet()
        val raw = prefs.getString(ACTIVE_PACKAGES, null) ?: return emptySet()
        return decodePackages(raw)
    }

    private fun load(key: String): List<BlockedApp> {
        val raw = prefs.getString(key, null) ?: return emptyList()
        return decodeApps(raw)
    }

    companion object {
        private const val PREFS = "foqui_focus"
        private const val PROMPTED = "permission.prompted"
        private const val ACTIVE_PACKAGES = "active.packages"
        private const val ACTIVE_LIST = "active.list"
        private const val ACTIVE_ENDS = "active.ends"
        private const val MINIMUM_MS = 15 * 60 * 1000L
        private val lock = Any()

        fun get(context: Context): FocusBlockStore {
            val prefs = context.applicationContext.getSharedPreferences(PREFS, Context.MODE_PRIVATE)
            return FocusBlockStore(prefs)
        }

        fun isServiceEnabled(context: Context): Boolean {
            val expected = ComponentName(context, FocusAccessibilityService::class.java).flattenToString()
            val enabled = Settings.Secure.getString(
                context.contentResolver,
                Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES,
            ) ?: return false
            val splitter = TextUtils.SimpleStringSplitter(':')
            splitter.setString(enabled)
            while (splitter.hasNext()) {
                if (splitter.next().equals(expected, ignoreCase = true)) return true
            }
            return false
        }

        private fun selectionKey(listId: String) = "selection.$listId"

        private fun draftKey(listId: String) = "draft.$listId"

        private fun encode(apps: List<BlockedApp>): String {
            val array = JSONArray()
            for (app in apps) {
                val obj = JSONObject()
                obj.put("package", app.packageName)
                obj.put("name", app.label)
                array.put(obj)
            }
            return array.toString()
        }

        private fun decodeApps(raw: String): List<BlockedApp> {
            return try {
                val array = JSONArray(raw)
                buildList {
                    for (index in 0 until array.length()) {
                        val obj = array.optJSONObject(index) ?: continue
                        val packageName = obj.optString("package")
                        if (packageName.isEmpty()) continue
                        val label = obj.optString("name").ifEmpty { packageName }
                        add(BlockedApp(packageName, label))
                    }
                }
            } catch (_: Exception) {
                emptyList()
            }
        }

        private fun decodePackages(raw: String): Set<String> {
            return try {
                val array = JSONArray(raw)
                buildSet {
                    for (index in 0 until array.length()) {
                        val packageName = array.optString(index)
                        if (packageName.isNotEmpty()) add(packageName)
                    }
                }
            } catch (_: Exception) {
                emptySet()
            }
        }
    }
}
