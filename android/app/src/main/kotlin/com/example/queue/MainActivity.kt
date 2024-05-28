package com.glootea.queueminder

import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.glootea.queueminder/share"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if(call.method == "share") {
                val shareIntent: Intent = Intent("com.google.android.gms.SHARE_NEARBY")
                shareIntent.setPackage ("com.google.android.gms")
                val text = call.argument<String>("text");
                shareIntent.putExtra(Intent.EXTRA_TEXT, text)
                shareIntent.type = "text/plain"
                startActivity(shareIntent)
            }else {
                throw Exception("Method not implemented")
            }

        }
    }

}
