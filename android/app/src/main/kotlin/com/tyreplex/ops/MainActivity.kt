package com.tyreplex.ops

import android.Manifest
import android.annotation.TargetApi
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.provider.Telephony
import android.telephony.SmsManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import android.net.ConnectivityManager


class MainActivity : FlutterActivity() {

     val MCHANNEL = "tyre.plex"
    val ECHANNEL = "tyre.plex.sms.receiver"

// ...............................*..................*...........................*.....................*
//     GeneratedPluginRegistrant.registerWith(flutterEngine)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, MCHANNEL)
            .setMethodCallHandler { call, result ->
            if(call.method == "sendsms") {
                val phone = call.argument<String>("phone")
                val msg = call.argument<String>("msg")
                if (phone != null && msg != null) {
                        sendSms(phone, msg)
                }
            }
//            else if(call.method == "receive_sms"){
//                val smsReceiver = object: BroadcastReceiver(){
//                    override fun onReceive(p0: Context?, p1: Intent?) {
//                        for (sms in Telephony.Sms.Intents.getMessagesFromIntent(p1)) {
//                            result.success(sms.displayMessageBody)
//                        }
//                    }
//                }
//                registerReceiver(smsReceiver, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
//            }
            else if(call.method == "startExampleService" ) {
                startService(Intent(this, SmsForegroundService::class.java))
                result.success("Foreground Service Started!")
                }
           else if(call.method == "stopExampleService" ) {
                stopService(Intent(this, SmsForegroundService::class.java))
                result.success("Stopped!")
            }
            else if(call.method == "startSmsReceiver" ) {
//                val Smsreceiver: BroadcastReceiver = Sms()
//                registerReceiver(Smsreceiver, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))

//                var received = startService(Intent(this,  Sms::class.java))
//                result.success(received)
//                -result.success("Successfully hit Sms receiver")
            }
            else {
                result.notImplemented()

            }
        }

    registerReceiver(smsReceiver, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
    EventChannel(flutterEngine.dartExecutor.binaryMessenger, ECHANNEL)
        .setStreamHandler(smsReceiver)



    }

// ...............................*..................*...........................*.....................*

 private val smsReceiver = object : EventChannel.StreamHandler, BroadcastReceiver() {
    var eventSink: EventChannel.EventSink? = null
    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        registerReceiver(this, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
        eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }

    override fun onReceive(p0: Context?, p1: Intent?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            for (sms in Telephony.Sms.Intents.getMessagesFromIntent(p1)) {
                eventSink?.success(sms.displayMessageBody)
            }
        }
    }
}

// ...............................*..................*...........................*.....................*

    @TargetApi(Build.VERSION_CODES.HONEYCOMB)
    private fun sendSms(phoneNumber: String?, message: String?) {
        try {
            val smsManager = SmsManager.getDefault()
            smsManager.sendTextMessage(phoneNumber, null, message, null, null)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

// ...............................*..................*...........................*.....................*

//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            if (checkSelfPermission(
//                    Manifest.permission.SEND_SMS)
//                != PackageManager.PERMISSION_GRANTED) {
//
//                // Should we show an explanation?
//                if (shouldShowRequestPermissionRationale(
//                        Manifest.permission.SEND_SMS)) {
//
//                    // Show an explanation to the user *asynchronously* -- don't block
//                    // this thread waiting for the user's response! After the user
//                    // sees the explanation, try again to request the permission.
//                } else {
//
//                    // No explanation needed, we can request the permission.
//                    requestPermissions(arrayOf(Manifest.permission.SEND_SMS),
//                        0)
//
//                    // MY_PERMISSIONS_REQUEST_SEND_SMS is an
//                    // app-defined int constant. The callback method gets the
//                    // result of the request.
//                }
//            }
//        }
//
//    }
// ...............................*..................*...........................*.....................*

//    override fun onRequestPermissionsResult(requestCode: Int,
//                                            permissions: Array<String>, grantResults: IntArray) {
//        when (requestCode) {
//            0 -> {
//
//                // If request is cancelled, the result arrays are empty.
//                if (grantResults.isNotEmpty()
//                    && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
//
//                    // permission was granted, yay! Do the
//                    // contacts-related task you need to do.
//                } else {
//
//                    // permission denied, boo! Disable the
//                    // functionality that depends on this permission.
//                }
//                return
//            }
//        }
//    }


// ...............................*..................*...........................*.....................*

//    private fun getSmsManager(): SmsManager {
//        val subscriptionId = SmsManager.getDefaultSmsSubscriptionId()
//
//        val smsManager = SmsManager.getDefault()
//                ?: throw RuntimeException("Flutter Telephony: Error getting SmsManager")
//        if (subscriptionId != SubscriptionManager.INVALID_SUBSCRIPTION_ID) {
//            return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
//                smsManager.createForSubscriptionId(subscriptionId)
//            } else {
//                SmsManager.getSmsManagerForSubscriptionId(subscriptionId)
//            }
//        }
//        return smsManager
//    }

// ...............................*..................*...........................*.....................*

//    private val CHANNEL = "tyre.plex"
//
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call ->
//            if (call.method == "sendsms") {
//                var phone = call.arguments<String?>("phone")
//                var msg = call.arguments<String?>("msg")
//                sendSms(phone,msg)
//            } else {
//                result.notImplemented()
//
//            }
//        }
//    }
//
//    private fun sendSms(phoneNumber: String?, message: String?) {
//        val number: String? = phoneNumber
//        val msg: String? = message
//        try {
//            val smsManager: SmsManager = SmsManager.getDefault()
//            smsManager.sendTextMessage(number, null, msg, null, null)
//            Toast.makeText(getApplicationContext(), "Message Sent", Toast.LENGTH_LONG).show()
//        } catch (e: Exception) {
//            Toast.makeText(getApplicationContext(), "Some fields is Empty", Toast.LENGTH_LONG).show()
//        }
//    }


// ...............................*..................*...........................*.....................*


    //    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        val smsReceiver = object : EventChannel.StreamHandler, BroadcastReceiver() {
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
//        registerReceiver(smsReceiver, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
//        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
//            .setStreamHandler(smsReceiver)
//    }

// ...............................*..................*...........................*.....................*

}

