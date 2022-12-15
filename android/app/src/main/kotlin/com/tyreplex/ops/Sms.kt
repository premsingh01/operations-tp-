package com.tyreplex.ops

import android.annotation.TargetApi
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.os.Bundle
import android.telephony.SmsMessage
import android.widget.Toast
import android.util.Log



class Sms : BroadcastReceiver() {

//val ECHANNEL = "tyre.plex.sms.receiver"
//
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//    EventChannel(flutterEngine.dartExecutor.binaryMessenger, ECHANNEL)
//    .setStreamHandler(smsReceiver)

    private val TAG: String = Sms::class.java.getSimpleName()
    val pdu_type = "pdus"

    @TargetApi(Build.VERSION_CODES.M)
    override fun onReceive(context: Context?, intent: Intent) {
//        registerReceiver(this, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
        // Get the SMS message.
        val bundle: Bundle? = intent.getExtras()
        val msgs: Array<SmsMessage?>
        var strMessage = ""
        val format: String? = bundle?.getString("format")
        // Retrieve the SMS message received.
        val pdus = bundle?.get(pdu_type) as Array<Any>
        if (pdus != null) {
            // Check the Android version.
            val isVersionM: Boolean = Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
            // Fill the msgs array.
            msgs = arrayOfNulls<SmsMessage>(pdus.size)
            for (i in msgs.indices) {
                // Check Android version and use appropriate createFromPdu.
                if (isVersionM) {
                    // If Android version M or newer:
                    msgs[i] = SmsMessage.createFromPdu(pdus[i] as ByteArray, format)
                } else {
                    // If Android version L or older:
                    msgs[i] = SmsMessage.createFromPdu(pdus[i] as ByteArray)
                }
                // Build the message to show.
                strMessage += "SMS from " + msgs[i]?.getOriginatingAddress()
                strMessage += """ :${msgs[i]?.getMessageBody().toString()}
                   
"""
                // Log and display the SMS message.
                Log.e(TAG, "onReceive: $strMessage")
                Toast.makeText(context, strMessage, Toast.LENGTH_LONG).show()
            }
//            return strMessage

        }
    }

}

