package com.example.foqui

import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.content.pm.ResolveInfo
import android.graphics.drawable.Drawable
import android.os.Build
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.EditText
import android.widget.ImageView
import android.widget.ListView
import android.widget.TextView
import java.text.Collator
import kotlin.concurrent.thread

/**
 * Chooses the installed apps a block list will shield.
 *
 * Launchable apps only, so the full installed-app permission is not required.
 */
class AppPickerActivity : Activity() {
    private lateinit var listId: String
    private val selected = linkedSetOf<String>()
    private var apps = listOf<LaunchableApp>()
    private var shown = listOf<LaunchableApp>()
    private var delivered = false
    private var loaded = false
    private lateinit var listView: ListView
    private lateinit var emptyView: TextView
    private lateinit var adapter: AppAdapter

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val id = intent.getStringExtra(EXTRA_LIST_ID)
        if (id.isNullOrEmpty()) {
            finish()
            return
        }
        listId = id
        val existing = FocusBlockStore.get(this).loadDraftOrSaved(listId)
        selected.addAll(existing.map { it.packageName })
        if (savedInstanceState != null) {
            selected.clear()
            selected.addAll(savedInstanceState.getStringArrayList(STATE_SELECTED).orEmpty())
        }

        setContentView(R.layout.app_picker)
        listView = findViewById(R.id.picker_list)
        emptyView = findViewById(R.id.picker_empty)
        adapter = AppAdapter()
        listView.adapter = adapter
        emptyView.setText(R.string.picker_loading)

        findViewById<EditText>(R.id.picker_search).addTextChangedListener(
            object : TextWatcher {
                override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

                override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
                    applyFilter(s?.toString().orEmpty())
                }

                override fun afterTextChanged(s: Editable?) {}
            },
        )
        findViewById<View>(R.id.picker_cancel).setOnClickListener { finish() }
        findViewById<View>(R.id.picker_done).setOnClickListener { saveAndClose() }

        thread(name = "foqui-apps") {
            val found = loadApps()
            runOnUiThread {
                if (isDestroyed) return@runOnUiThread
                apps = found
                loaded = true
                applyFilter(findViewById<EditText>(R.id.picker_search).text?.toString().orEmpty())
            }
        }
    }

    override fun onStart() {
        super.onStart()
        isOpen = true
    }

    override fun onStop() {
        isOpen = false
        super.onStop()
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putStringArrayList(STATE_SELECTED, ArrayList(selected))
    }

    override fun onDestroy() {
        if (isFinishing) deliver(null)
        super.onDestroy()
    }

    private fun saveAndClose() {
        val chosen = apps
            .filter { it.packageName in selected }
            .map { BlockedApp(it.packageName, it.label) }
        val store = FocusBlockStore.get(this)
        store.saveDraft(listId, chosen)
        deliver(store.counts(chosen))
        finish()
    }

    private fun deliver(value: Any?) {
        if (delivered) return
        delivered = true
        FocusShieldPlugin.finishPicker(value)
    }

    private fun applyFilter(query: String) {
        val needle = query.trim().lowercase(java.util.Locale.getDefault())
        shown = if (needle.isEmpty()) {
            apps
        } else {
            apps.filter { it.label.lowercase(java.util.Locale.getDefault()).contains(needle) }
        }
        adapter.notifyDataSetChanged()
        emptyView.visibility = if (shown.isEmpty()) View.VISIBLE else View.GONE
        emptyView.setText(if (loaded) R.string.picker_empty else R.string.picker_loading)
    }

    private fun loadApps(): List<LaunchableApp> {
        val intent = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER)
        val resolved = queryLaunchers(packageManager, intent)
        val byPackage = linkedMapOf<String, LaunchableApp>()
        for (info in resolved) {
            val packageName = info.activityInfo?.packageName ?: continue
            if (packageName == this.packageName || byPackage.containsKey(packageName)) continue
            val label = info.loadLabel(packageManager)?.toString()?.trim().orEmpty().ifEmpty { packageName }
            val icon = info.loadIcon(packageManager)
            byPackage[packageName] = LaunchableApp(packageName, label, icon)
        }
        val collator = Collator.getInstance()
        return byPackage.values.sortedWith { left, right -> collator.compare(left.label, right.label) }
    }

    private fun queryLaunchers(manager: PackageManager, intent: Intent): List<ResolveInfo> {
        return if (Build.VERSION.SDK_INT >= 33) {
            manager.queryIntentActivities(intent, PackageManager.ResolveInfoFlags.of(0))
        } else {
            @Suppress("DEPRECATION")
            manager.queryIntentActivities(intent, 0)
        }
    }

    private inner class AppAdapter : BaseAdapter() {
        override fun getCount(): Int = shown.size

        override fun getItem(position: Int): LaunchableApp = shown[position]

        override fun getItemId(position: Int): Long = shown[position].packageName.hashCode().toLong()

        override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
            val row = convertView ?: layoutInflater.inflate(R.layout.app_picker_row, parent, false)
            val app = shown[position]
            row.findViewById<ImageView>(R.id.picker_icon).setImageDrawable(app.icon)
            row.findViewById<TextView>(R.id.picker_name).text = app.label
            val box = row.findViewById<android.widget.CheckBox>(R.id.picker_check)
            box.isChecked = app.packageName in selected
            box.isClickable = false
            box.isFocusable = false
            row.setOnClickListener {
                if (!selected.add(app.packageName)) selected.remove(app.packageName)
                box.isChecked = app.packageName in selected
            }
            return row
        }
    }

    companion object {
        const val EXTRA_LIST_ID = "listId"
        private const val STATE_SELECTED = "selected"

        @Volatile
        var isOpen: Boolean = false
    }
}

private data class LaunchableApp(
    val packageName: String,
    val label: String,
    val icon: Drawable,
)
