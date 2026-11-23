package com.example.foqui

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        FocusShieldPlugin.register(flutterEngine.dartExecutor.binaryMessenger, this)
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        FocusShieldPlugin.detach()
        super.cleanUpFlutterEngine(flutterEngine)
    }
}
