import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart' as per;


class SmsReceiver extends GetxController{

  @override
  void onInit() {
    getPermission().then((value) {
      if (value) {
        smsStream().listen((event) {
          print('__________________________@__________________@________ START');
          var sms = event;
          print('SMS RECEIVED ############# ${sms}');
          // setState(() {});
        });
      }
    });
    // TODO: implement onInit
    super.onInit();
  }



  static const _channel = EventChannel("tyre.plex");

  Stream smsStream() async* {
    yield* _channel.receiveBroadcastStream();
  }

  Future<bool> getPermission() async {
    if (await per.Permission.sms.status == per.PermissionStatus.granted) {
      return true;
    } else {
      if (await per.Permission.sms.request() == per.PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  // Future<String> sms() async {
  //
  //   // try {
  //   //   final result = await _channel..invokeMethod("receive_sms");
  //   //   return result as String;
  //   // } catch (e) {
  //   //   log(e.toString());
  //   //   return "";
  //   // }
  // }


}

