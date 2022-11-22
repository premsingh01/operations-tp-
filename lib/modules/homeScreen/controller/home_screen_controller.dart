
// import 'package:geocoding/geocoding.dart';
import 'dart:async';

import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart' as geo;
import 'package:location/location.dart';
import 'package:ops/api/repositories/location_repo.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;

class HomeScreenController extends GetxController {

  final RxBool _isLoading = true.obs;
  Timer? _timer;

  RxBool checkLoading() => _isLoading;


  @override
  void onInit() {
    //getLocation2();
    _timer = Timer.periodic(const Duration(seconds: 60),(timer)=> getLocation2());
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose(){
   _timer?.cancel();
   super.dispose();
  }



  getLocation2() async{
  // Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Location.instance.enableBackgroundMode(enable: true);

  _serviceEnabled = await Location.instance.serviceEnabled();
  if (!_serviceEnabled) {
  _serviceEnabled = await Location.instance.requestService();
  if (!_serviceEnabled) {
    return ;
  }
  }

  _permissionGranted = await Location.instance.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
  _permissionGranted = await Location.instance.requestPermission();
  if (_permissionGranted != PermissionStatus.granted) {
  return;
  }
  }

  _locationData = await Location.instance.getLocation();
  print('%%%%%%%%%%%%backgroundLocation++++++ ${_locationData}');

  _isLoading.value = false;
}


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
//     print('home screen controller position +++++++++++${position}');
//
//     List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
//      print('home screen controller placemark +++++++++++${placemark}');
//     // var lastPosition = await geo.Geolocator.getLastKnownPosition();
//     // print('##############${lastPosition}');
//
//     LocationRepo().sendLocation(position, placemark);
//
//     _isLoading.value = false;
//
//
//   }
}