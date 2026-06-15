package com.example.posture_pal

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.os.Bundle
import java.util.Timer
import java.util.TimerTask
import android.util.Log
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.app.PendingIntent
import android.content.Context

class PostureMonitoringService : Service(),
    SensorEventListener {

    private var timer: Timer? = null
    private var inactiveSeconds = 0L
    private var reminderShown = false
    private lateinit var sensorManager: SensorManager

    private var lastMovementTime =
        System.currentTimeMillis()

    private var lastX = 0f
    private var lastY = 0f
    private var lastZ = 0f

    companion object {
        const val CHANNEL_ID = "posture_monitoring"
        const val REMINDER_CHANNEL_ID = "stretch_reminders"
          var inactiveSecondsForUi = 0L
    }

    override fun onCreate() {
    super.onCreate()

    createNotificationChannel()

    val intent =
    packageManager.getLaunchIntentForPackage(
        packageName
    )

    val pendingIntent =
        PendingIntent.getActivity(
            this,
            0,
            intent,
            PendingIntent.FLAG_IMMUTABLE or
            PendingIntent.FLAG_UPDATE_CURRENT
        )

    val notification =
        Notification.Builder(
            this,
            CHANNEL_ID
        )
            .setContentTitle("PosturePal")
            .setContentText("Running")
            .setSmallIcon(
                android.R.drawable.ic_dialog_info
            )
            .setContentIntent(
                pendingIntent
            )
            .build()
    startForeground(
            1,
            notification,
            android.content.pm.ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC
        )

        sensorManager =
        getSystemService(
            SENSOR_SERVICE
        ) as SensorManager

        val accelerometer =
            sensorManager.getDefaultSensor(
                Sensor.TYPE_ACCELEROMETER
            )

        sensorManager.registerListener(
            this,
            accelerometer,
            SensorManager.SENSOR_DELAY_NORMAL
        )
    }

   override fun onStartCommand(
            intent: Intent?,
            flags: Int,
            startId: Int
        ): Int {

            timer?.cancel()

            timer = Timer()

           timer?.scheduleAtFixedRate(
                object : TimerTask() {
                    override fun run() {

                        inactiveSeconds =
                        (
                            System.currentTimeMillis()
                            -
                            lastMovementTime
                        ) / 1000

                    inactiveSecondsForUi =
                        inactiveSeconds

                        Log.d(
                            "PosturePal",
                            "Inactive: $inactiveSeconds"
                        )

                        if (
                            inactiveSeconds >= 60 &&
                            
                            !reminderShown
                        ) {

                            reminderShown = true

                            showReminderNotification()
                        }
                    }
                },
                0,
                1000
            )

            return return START_NOT_STICKY
        }

    override fun onBind(
        intent: Intent?
    ): IBinder? = null

    private fun createNotificationChannel() {

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

        val serviceChannel =
            NotificationChannel(
                CHANNEL_ID,
                "Posture Monitoring",
                NotificationManager.IMPORTANCE_LOW
            )

        val reminderChannel =
            NotificationChannel(
                REMINDER_CHANNEL_ID,
                "Stretch Reminders",
                NotificationManager.IMPORTANCE_HIGH
            )

        val manager =
            getSystemService(
                NotificationManager::class.java
            )

        manager.createNotificationChannel(
            serviceChannel
        )

        manager.createNotificationChannel(
            reminderChannel
        )
    }
}


    private fun showReminderNotification() {


        AppStateHolder.openStretch = true
            val intent =
            packageManager.getLaunchIntentForPackage(
                packageName
            )

        intent?.putExtra(
            "openStretch",
            true
        )

    val pendingIntent =
        PendingIntent.getActivity(
            this,
            1,
            intent,
            PendingIntent.FLAG_IMMUTABLE or
            PendingIntent.FLAG_UPDATE_CURRENT
        )

    val notification =
        Notification.Builder(
            this,
            REMINDER_CHANNEL_ID
        )
            .setContentTitle(
                "Time to Stretch"
            )
            .setContentText(
                "You've been inactive for a while."
            )
            .setSmallIcon(
                android.R.drawable.ic_dialog_info
            )
            .setContentIntent(
                pendingIntent
            )
            .setAutoCancel(true)
            .setCategory(
    Notification.CATEGORY_REMINDER
)
            .build()

    val manager =
        getSystemService(
            NotificationManager::class.java
        )

    manager.notify(
        2,
        notification
    )
}

    override fun onSensorChanged(
    event: SensorEvent?
        ) {

            if (event == null) return

            val movement =
                kotlin.math.abs(
                    event.values[0] - lastX
                ) +
                kotlin.math.abs(
                    event.values[1] - lastY
                ) +
                kotlin.math.abs(
                    event.values[2] - lastZ
                )

            lastX = event.values[0]
            lastY = event.values[1]
            lastZ = event.values[2]

            if (movement > 2f) {

                lastMovementTime =
                    System.currentTimeMillis()

                reminderShown = false
            }
        }

        override fun onAccuracyChanged(
            sensor: Sensor?,
            accuracy: Int
        ) {}

    override fun onDestroy() {
    timer?.cancel()

    sensorManager.unregisterListener(this)

    super.onDestroy()
}
}