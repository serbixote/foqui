package com.example.foqui

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.SystemClock
import android.view.View
import android.widget.TextView
import java.text.DateFormat
import java.util.Date
import java.util.Locale

/**
 * The screen shown over an app this session is blocking.
 *
 * OK leaves the blocked app. Go to Foqui opens this app. The block lifts
 * itself when the session timer runs out, even if Foqui is not open.
 */
class ShieldActivity : Activity() {
    private val handler = Handler(Looper.getMainLooper())
    private val liftBlock = Runnable {
        FocusBlockStore.get(this).clearIfExpired()
        finish()
        overridePendingTransition(0, 0)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (FocusBlockStore.get(this).clearIfExpired()) {
            finish()
            return
        }
        setContentView(R.layout.shield_activity)
        findViewById<TextView>(R.id.shield_message).text = ShieldCopy.message(FocusBlockStore.get(this).endsAtMillis())
        findViewById<TextView>(R.id.shield_open).text = ShieldCopy.openFoqui()
        findViewById<View>(R.id.shield_ok).setOnClickListener { goHome() }
        findViewById<View>(R.id.shield_open).setOnClickListener { openFoqui() }
        scheduleLift()
    }

    override fun onStart() {
        super.onStart()
        current = this
        isCovering = true
    }

    override fun onStop() {
        if (current == this) current = null
        isCovering = false
        super.onStop()
    }

    override fun onDestroy() {
        handler.removeCallbacks(liftBlock)
        if (current == this) current = null
        super.onDestroy()
    }

    @Deprecated("The shield closes the blocked app instead of returning to it.")
    override fun onBackPressed() {
        goHome()
    }

    private fun scheduleLift() {
        val ends = FocusBlockStore.get(this).endsAtMillis()
        if (ends <= 0L) return
        val delay = ends - System.currentTimeMillis()
        if (delay <= 0L) {
            liftBlock.run()
            return
        }
        handler.postDelayed(liftBlock, delay)
    }

    private fun goHome() {
        suppressBriefly()
        val home = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_HOME).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK
        }
        startActivity(home)
        finish()
        overridePendingTransition(0, 0)
    }

    private fun openFoqui() {
        suppressBriefly()
        val intent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or
                Intent.FLAG_ACTIVITY_CLEAR_TOP or
                Intent.FLAG_ACTIVITY_SINGLE_TOP
        }
        startActivity(intent)
        finish()
        overridePendingTransition(0, 0)
    }

    companion object {
        @Volatile
        var isCovering: Boolean = false

        @Volatile
        var suppressUntil: Long = 0L

        private var current: ShieldActivity? = null

        fun dismiss() {
            current?.runOnUiThread {
                current?.finish()
                current?.overridePendingTransition(0, 0)
            }
            isCovering = false
        }

        fun suppressBriefly() {
            suppressUntil = SystemClock.uptimeMillis() + 700L
        }
    }
}

/** Same words as the iPhone shield. */
private object ShieldCopy {
    fun message(endsAtMillis: Long): String {
        val whenText = if (endsAtMillis > System.currentTimeMillis()) {
            timed(clock(endsAtMillis))
        } else {
            untilYouFinish()
        }
        return "${blocking()} $whenText"
    }

    fun openFoqui(): String {
        return when (language()) {
            "es" -> "Ir a Foqui"
            "de" -> "Zu Foqui"
            "pt" -> "Ir para o Foqui"
            "fr" -> "Aller à Foqui"
            else -> "Go to Foqui"
        }
    }

    private fun blocking(): String {
        return when (language()) {
            "es" -> "Foqui está bloqueando esta app durante tu sesión."
            "de" -> "Foqui blockiert diese App während deiner Sitzung."
            "pt" -> "O Foqui está bloqueando este app durante a sua sessão."
            "fr" -> "Foqui bloque cette app pendant votre session."
            else -> "Foqui is blocking this app during your session."
        }
    }

    private fun untilYouFinish(): String {
        return when (language()) {
            "es" -> "Volveré cuando termines."
            "de" -> "Ich komme zurück, wenn du fertig bist."
            "pt" -> "Volto quando você terminar."
            "fr" -> "Je reviens quand vous terminez."
            else -> "I'll come back when you finish."
        }
    }

    private fun timed(time: String): String {
        return when (language()) {
            "es" -> "Volveré a las $time."
            "de" -> "Ich komme um $time zurück."
            "pt" -> "Volto às $time."
            "fr" -> "Je reviens à $time."
            else -> "I'll come back at $time."
        }
    }

    private fun clock(endsAtMillis: Long): String {
        val format = DateFormat.getTimeInstance(DateFormat.SHORT, Locale.getDefault())
        return format.format(Date(endsAtMillis))
    }

    private fun language(): String = Locale.getDefault().language.lowercase(Locale.US)
}
