package com.tyreplex.ops

import androidx.annotation.RequiresApi
import android.graphics.Color
import android.app.Notification
import android.app.NotificationManager
import android.app.NotificationChannel
import android.app.Service
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import android.telephony.SmsManager
import androidx.annotation.NonNull
import java.util.Timer
import java.util.TimerTask
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel
import android.provider.Telephony
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter


class SmsForegroundService : Service()  {


    val ECHANNEL = "tyre.plex.foreground.sms.receiver"

//    val CHANNEL = "tyre.plex.foreground"
//
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//                call, result ->
//            if(call.method == "sendsms") {
//                val phone = call.argument<String>("phone")
//                val msg = call.argument<String>("msg")
//                if (phone != null && msg != null) {
//                    sendSms(phone, msg)
//                }
//            } else {
//                result.notImplemented()
//
//            }
//        }
//    }

//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//    registerReceiver(smsReceiver, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
//    EventChannel(flutterEngine.dartExecutor.binaryMessenger, ECHANNEL)
//    .setStreamHandler(smsReceiver)
//
//
//         val smsReceiver = object : EventChannel.StreamHandler, BroadcastReceiver() {
//            var eventSink: EventChannel.EventSink? = null
//            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
//                eventSink = events
//            }
//
//            override fun onCancel(arguments: Any?) {
//                eventSink = null
//            }
//
//            override fun onReceive(p0: Context?, p1: Intent?) {
//                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
//                    for (sms in Telephony.Sms.Intents.getMessagesFromIntent(p1)) {
//                        eventSink?.success(sms.displayMessageBody)
//                    }
//                }
//            }
//        }



        override fun onCreate() {
        super.onCreate()
        startForeground()
        serviceRunning = true
        Timer().schedule(object : TimerTask() {
            override fun run() {
                if (serviceRunning == true) {
                    updateNotification("I got updated!")
                }
            }
        }, 5000)
    }

//    @TargetApi(Build.VERSION_CODES.HONEYCOMB)
//    private fun sendSms(phoneNumber: String, message: String) {
//
////        val number: String = phoneNumber
////        val msg: String = message
//        try {
////            val smsManager = getSmsManager()
//            val smsManager = SmsManager.getDefault()
//            smsManager.sendTextMessage(phoneNumber, null, message, null, null)
////            Toast.makeText(getApplicationContext(), "Message Sent", Toast.LENGTH_LONG).show()
//        } catch (e: Exception) {
//            e.printStackTrace()
////            Toast.makeText(getApplicationContext(), "Some fields is Empty", Toast.LENGTH_LONG).show()
//        }
//
//    }


    val notificationId = 1
    var serviceRunning = false
    lateinit var builder: NotificationCompat.Builder
    lateinit var channel: NotificationChannel
    lateinit var manager: NotificationManager



    override fun onDestroy() {
        super.onDestroy()
        serviceRunning = false
    }


    @RequiresApi(Build.VERSION_CODES.O)
    private fun createNotificationChannel(channelId: String, channelName: String): String {
        channel = NotificationChannel(channelId,
            channelName, NotificationManager.IMPORTANCE_NONE)
        channel.lightColor = Color.BLUE
        channel.lockscreenVisibility = Notification.VISIBILITY_PRIVATE
        manager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        manager.createNotificationChannel(channel)
        return channelId
    }

    private fun startForeground() {
        val channelId =
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                createNotificationChannel("foreground_service", "Sms Foreground Service")
            } else {
                // If earlier version channel ID is not used
                // https://developer.android.com/reference/android/support/v4/app/NotificationCompat.Builder.html#NotificationCompat.Builder(android.content.Context)
                ""
            }
        builder = NotificationCompat.Builder(this, channelId)
        builder
            .setOngoing(true)
            .setOnlyAlertOnce(true)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle("Sms Foreground Service")
            .setContentText("Sms Foreground Service")
            .setCategory(Notification.CATEGORY_SERVICE)
        startForeground(1, builder.build())
    }

    private fun updateNotification(text: String) {
        builder
            .setContentText(text)
        manager.notify(notificationId, builder.build());
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

}