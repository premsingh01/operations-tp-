import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:ops/api/repositories/location_repo.dart';
import 'package:ops/util/function.dart';
import 'package:ops/util/sms/smsReceiver.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart' as tel;
import 'package:flutter_sms/flutter_sms.dart' as fs;
import 'package:url_launcher/url_launcher.dart' as ur;

import '../../../main.dart';

class HomeScreenController extends GetxController {
  Timer? _timer;

  @override
  void onInit() {
    // getBatteryOptimizationPermission();
    // _startService();
    // getSmsPermission();
    // initPlatformState();
    //  receiveSms();
    // _timer = Timer.periodic(Duration(seconds: 10), (timer) => testing());
    // TODO: implement onInit
    super.onInit();
  }

  MethodChannel platform = const MethodChannel('tyre.plex');

   _startService() async {
    try {
      final result = await platform.invokeMethod('startExampleService');
      // setState(() {
      //   _serverState = result;
      // });
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

   _stopService() async {
    try {
      final result = await platform.invokeMethod('stopExampleService');
      // setState(() {
      //   _serverState = result;
      // });
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  //receiving device messages on app
  // receiveSms() {
  //   tel.Telephony telephony = tel.Telephony.instance;
  //   telephony.listenIncomingSms(
  //     listenInBackground: true,
  //     onBackgroundMessage: backgrounMessageHandler,
  //     onNewMessage: (tel.SmsMessage message) {
  //       print('Sender Name: ${message.address}'); //+977981******67, sender number
  //       print('Body: ${message.body}'); //sms text
  //
  //       String? senderno = message.address;
  //       String? smsBody = message.body;
  //
  //       sendSms(senderno, smsBody);
  //     },
  //
  //   );
  // }

  Future<void> sendSms(String? SenderNo, String? smsBody) async {
     print('HomeScreen controller send sms working');
    final prefs = await SharedPreferences.getInstance();
    String? Number = prefs.getString('number');
    String mobileNumber = '+91$Number';

    var message = "Sender Name: $SenderNo \n Body: $smsBody";
     print('HomeScreen controller send sms working after shared preference');

    // method channel for sending sms
    await platform.invokeMethod("sendsms", <String, dynamic>{
      "phone": mobileNumber,
      "msg": message,
    }
    );
     print('HomeScreen controller after sending Sms');

    //flutter_sms(WORKS ONLY IN FOREGROUND)
    // List<String> recipents = ["+91$Number"];
    //
    // String _result = await fs.sendSMS(message: message, recipients: recipients, sendDirect: true)
    //     .catchError((onError) {
    //   print(onError);
    // });
    // print(_result);

    //telephony(works only in emulator) for both
    // tel.Telephony.instance.sendSms(to: '$mobileNumber', message: '$message');
  }

  CommonFunctions controller = CommonFunctions();

  tryTest() {
    _timer = Timer.periodic(Duration(seconds: 60), (timer) => testing());
  }

  testing() async {
    final value = await controller.getGeolocation();
    var lat = value.latitude;
    var long = value.longitude;
    print('******************${lat}');
    print('@@@@@@@@@@@@@@@@@@${long}');
    List place = value.placemark;
    // List place= [
    //   'i', 'am', 'post', 'api', 'response',
    // ];

    //postGeoLocation ke lat ko String se Double krna h
    //await controller.postGeoLocation(lat, long, place);
  }

  getBatteryOptimizationPermission() async {
    var BatteryStatus = per.Permission.ignoreBatteryOptimizations;
    if (await BatteryStatus.isPermanentlyDenied) {
      print('Battery Optimization is permenantly denied');
      per.Permission.ignoreBatteryOptimizations.request();
    }
    if (await BatteryStatus.isRestricted || await BatteryStatus.isDenied) {
      per.Permission.ignoreBatteryOptimizations.request();
    }

    per.Permission.ignoreBatteryOptimizations.isGranted;

    return;
  }

  getSmsPermission() async {
    var smsStatus = per.Permission.sms;
    if (await smsStatus.isPermanentlyDenied) {
      print('Sms permission is permenantly denied');
      per.Permission.sms.request();
    }
    if (await smsStatus.isRestricted || await smsStatus.isDenied) {
      per.Permission.sms.request();
    }

    per.Permission.sms.isGranted;
    return;
  }

// location as loc
//   final RxBool _isLoading = true.obs;
//   RxDouble _latitude = 0.0.obs;
//   RxDouble _longitude = 0.0.obs;
//   Timer? _timer;
//   List<Placemark> placemark = [];
//
//   RxBool checkLoading() => _isLoading;
//
//   @override
//   void onInit() {
//     // getLocation2();
//     _timer = Timer.periodic(const Duration(seconds: 60), (timer) => getLocation2());
//     // TODO: implement onInit
//     super.onInit();
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   getLocation2() async {
//     // Location location = new Location();
//
//     bool _serviceEnabled;
//     loc.PermissionStatus _permissionGranted;
//     loc.LocationData _locationData;
//
//     loc.Location.instance.enableBackgroundMode(enable: true);
//
//     _serviceEnabled = await loc.Location.instance.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await loc.Location.instance.requestService();
//       // if (!_serviceEnabled) {
//       //   return;
//       // }
//     }
//
//     _permissionGranted = await loc.Location.instance.hasPermission();
//     if (_permissionGranted == loc.PermissionStatus.denied) {
//       _permissionGranted = await loc.Location.instance.requestPermission();
//       if (_permissionGranted != loc.PermissionStatus.granted) {
//         return;
//       }
//     }
//
//     _locationData = await loc.Location.instance.getLocation();
//     _latitude.value = _locationData.latitude!;
//     _longitude.value = _locationData.longitude!;
//     print('%%%%%%%%%%%%backgroundLocation++++++ ${_locationData}');
//
//     List<Placemark> placemark =
//         await placemarkFromCoordinates(_latitude.value, _longitude.value);
//     print('home screen controller placemark +++++++++++${placemark}');
//
//     print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ +++++++++++@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
//
//     LocationRepo().sendLocation(_latitude.value, _longitude.value, placemark);
//
//     // loc.Location.instance.onLocationChanged.listen((loc.LocationData currentLocation) async{
//     //   _latitude.value = currentLocation.latitude!;
//     //   _longitude.value = currentLocation.longitude!;
//     //
//     //   print('onchanged++++++++LAT+++++++++${_latitude.value}');
//     //   print('onchnaged----------LONG---------${_longitude.value}');
//     //
//     //   List<Placemark> placemark = await placemarkFromCoordinates(_latitude.value, _longitude.value);
//     //   print('home screen controller placemark +++++++++++${placemark}');
//     //
//     //   LocationRepo().sendLocation(_latitude.value, _longitude.value, placemark);
//     //
//     // });
//
//     // List<Placemark> placemark = await placemarkFromCoordinates(_latitude.value, _longitude.value);
//     // print('home screen controller placemark +++++++++++${placemark}');
//     //
//     //    LocationRepo().sendLocation(_latitude.value, _longitude.value, placemark);
//
//     _isLoading.value = false;
//   }

//background geo location
// @override
// void onInit() {
//   getLocation1();
//   // TODO: implement onInit
//   super.onInit();
// }
//
// final RxBool _isLoading = true.obs;
//
// RxBool checkLoading() => _isLoading;
//
// getLocation1() async{
//   var position = await bg.BackgroundGeolocation.getCurrentPosition(
//       persist: false,     // <-- do not persist this location
//       desiredAccuracy: 0, // <-- desire best possible accuracy
//       timeout: 30000,     // <-- wait 30s before giving up.
//       samples: 3          // <-- sample 3 location before selecting best.
//   );
//   print('%%%%%%%%%%%%backgroundLocation ${position}');
//   //     .then((bg.Location location) {
//   //   print('[getCurrentPosition] - $location');
//   // }).catchError((error) {
//   //   print('[getCurrentPosition] ERROR: $error');
//   // });
//   _isLoading.value = false;
// }

//geolocator
// final RxBool _isLoading = true.obs;
// final RxDouble _latitude = 0.0.obs;
// final RxDouble _longitude = 0.0.obs;
// Timer? _timer;
//
// //instance for them to be called
//   RxBool checkLoading() => _isLoading;
//   RxDouble checkLatitude() => _latitude;
//   RxDouble checkLongitude() => _longitude;
//
// @override
//   void onInit() {
//   _timer = Timer.periodic(const Duration(seconds: 60),(timer)=> getLocation());
//   // getLocation();
//     // TODO: implement onInit
//     super.onInit();
//   }
//   @override
//   void dispose(){
//   _timer?.cancel();
//     super.dispose();
//   }
//
//
//
//   getLocation() async{
//     bool isServiceEnabled;
//     geo.LocationPermission locationPermission;
//
//
//     isServiceEnabled = await geo.Geolocator.isLocationServiceEnabled();
//
//     //return if service is enabled
//     if(!isServiceEnabled) {
//       await geo.Geolocator.openLocationSettings();
//       return Future.error('Location Not Enabled');
//     }
//
//     //status of permission
//     locationPermission = await geo.Geolocator.checkPermission();
//
//     if(locationPermission == geo.LocationPermission.deniedForever) {
//       return Future.error('Location Permission Are Denied Forever');
//     }
//     else if(locationPermission == geo.LocationPermission.denied) {
//
//       //request Permission
//       locationPermission = await geo.Geolocator.requestPermission();
//       if(locationPermission == geo.LocationPermission.denied) {
//         return Future.error('Location Permission Denied');
//       }
//
//     }
//
//     var position = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.best);
//     _latitude.value = position.latitude!;
//     _longitude.value = position.longitude!;
//     print('home screen controller position +++++++++++${position}');
//
//     List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
//      print('home screen controller placemark +++++++++++${placemark}');
//     // var lastPosition = await geo.Geolocator.getLastKnownPosition();
//     // print('##############${lastPosition}');
//
//     LocationRepo().sendLocation(_latitude.value, _longitude.value, placemark);
//
//     _isLoading.value = false;
//
//
//   }
}
