package com.example.posture_pal
import io.flutter.plugin.common.EventChannel
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.Timer
import java.util.TimerTask


object AppStateHolder {
    var openStretch = false
    var serviceRunning = false
}
class MainActivity : FlutterActivity() {

    private val CHANNEL = "posture_pal/service"

    override fun configureFlutterEngine(
        flutterEngine: FlutterEngine
    ) {
        super.configureFlutterEngine(
            flutterEngine
        )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->

            when (call.method) {

                "openStretch" -> {

                        result.success(
                            AppStateHolder.openStretch
                        )

                        AppStateHolder.openStretch = false
                    }

                "startService" -> {

                    AppStateHolder.serviceRunning = true

                    val intent = Intent(
                        this,
                        PostureMonitoringService::class.java
                    )

                    startForegroundService(
                        intent
                    )

                    result.success(
                        null
                    )
                }

                "stopService" -> {

                     AppStateHolder.serviceRunning = false

                    val intent = Intent(
                        this,
                        PostureMonitoringService::class.java
                    )

                    stopService(
                        intent
                    )

                    result.success(
                        null
                    )
                }

                "serviceStatus" -> {

                    result.success(
                        AppStateHolder.serviceRunning
                    )
                }

                else -> {
                    result.notImplemented()
                }
            }
        }

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "posture_pal/monitoring"
        ).setStreamHandler(
            object : EventChannel.StreamHandler {

                private var timer: Timer? = null

                override fun onListen(
                    arguments: Any?,
                    events: EventChannel.EventSink?
                ) {

                    timer = Timer()

                    timer?.scheduleAtFixedRate(
                        object : TimerTask() {
                            override fun run() {

                                events?.success(
                                    PostureMonitoringService
                                        .inactiveSecondsForUi
                                )
                            }
                        },
                        0,
                        1000
                    )
                }

                override fun onCancel(
                    arguments: Any?
                ) {
                    timer?.cancel()
                }
            }
        )
    }
}