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

import '../../../main.dart';
import '../../../util/permission.dart';

class HomeScreenController extends GetxController {
  Timer? _timer;

  @override
  void onInit() {
    Permission().getBatteryOptimizationPermission();
    tryTest();
    print('i am in HomeScreenController');
    // _timer = Timer.periodic(Duration(seconds: 14), (timer) => testing());
    // TODO: implement onInit
    super.onInit();
  }

  CommonFunctions controller = CommonFunctions();

  tryTest() {
    _timer = Timer.periodic(Duration(seconds: 14), (timer) => testing());
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

    await controller.postGeoLocation(lat, long, place);
  }

  Future<void> startService() async {
    MethodChannel platform = const MethodChannel('tyre.plex');
    try {
      final result = await platform.invokeMethod('startExampleService');
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  Future<void> stopService() async {
    MethodChannel platform = const MethodChannel('tyre.plex');
    try {
      final result = await platform.invokeMethod('stopExampleService');
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
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
