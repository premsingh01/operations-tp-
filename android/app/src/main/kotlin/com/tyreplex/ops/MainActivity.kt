package com.tyreplex.ops

import android.annotation.TargetApi
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.provider.Telephony
import android.telephony.SmsManager
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel


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
            else if(call.method == "locationService" ) {
//                 if (!checkPermissions()) {
//                  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//                    requestPermissions()
//                  }
//             }
//            else {
//               getLastLocation()
//            }
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
//main
//    private fun getLocation() {
//        locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
////        if ((ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED)) {
////            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.ACCESS_FINE_LOCATION), locationPermissionCode)
////        }
////        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 5000, 5f, this)
//
//        if (isGPSEnabled) {
//            if (location == null) {
//                //check the network permission
//                if (ActivityCompat.checkSelfPermission(
//                        mContext,
//                        Manifest.permission.ACCESS_FINE_LOCATION
//                    ) !== PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
//                        mContext,
//                        Manifest.permission.ACCESS_COARSE_LOCATION
//                    ) !== PackageManager.PERMISSION_GRANTED
//                ) {
//                    ActivityCompat.requestPermissions(
//                        mContext as Activity?,
//                        arrayOf<String>(
//                            android.Manifest.permission.ACCESS_FINE_LOCATION,
//                            Manifest.permission.ACCESS_COARSE_LOCATION
//                        ),
//                        101
//                    )
//                }
//                locationManager.requestLocationUpdates(
//                    LocationManager.GPS_PROVIDER,
//                    MIN_TIME_BW_UPDATES,
//                    MIN_DISTANCE_CHANGE_FOR_UPDATES, this
//                )
//                Log.d("GPS Enabled", "GPS Enabled")
//                if (locationManager != null) {
//                    location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER)
//                    if (location != null) {
//                        latitude = location.getLatitude()
//                        longitude = location.getLongitude()
//                    }
//                }
//            }
//        }
//    }

//    private fun getLastLocation() {
//        var lastLocation: Location? = null
//        var latitudeLabel: String? = null
//        var longitudeLabel: String? = null
//        var latitudeText: TextView? = null
//        var longitudeText: TextView? = null
//        fusedLocationClient?.lastLocation!!.addOnCompleteListener(this) { task ->
//            if (task.isSuccessful && task.result != null) {
//                lastLocation = task.result
//                latitudeText!!.text = latitudeLabel + ": " + (lastLocation)!!.latitude
//                longitudeText!!.text = longitudeLabel + ": " + (lastLocation)!!.longitude
//            }
//            else {
//                Log.w(TAG, "getLastLocation:exception", task.exception)
//                showMessage("No location detected. Make sure location is enabled on the device.")
//            }
//        }
//    }


//
//    class locationService: LocationListener(){
//
//
//    fun getLocation() {
//        locationManager = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
////        var locationManager: LocationManager
//        val latitude: String
//        val longitude: String
//
//        if (locationManager != null) {
//            location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);
//
//            if (location != null) {
//                latitude = location.getLatitude();
//                longitude = location.getLongitude();
//            }
//        }
//
//        gpsTracker = GpsTracker(this@locationService)
//        if (gpsTracker.canGetLocation()) {
//            val latitude: Double = gpsTracker.getLatitude()
//            val longitude: Double = gpsTracker.getLongitude()
////            tvLatitude.setText(latitude.toString())
////            tvLongitude.setText(longitude.toString())
//        }
//    }
//}

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

