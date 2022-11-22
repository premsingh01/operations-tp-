import 'dart:async';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart' as geo;
// import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:ops/modules/homeScreen/view/home_screen.dart';
import 'package:ops/modules/login/view/login_screen.dart';

class SplashScreenController extends GetxController {

  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

//instance for them to be called
  RxBool checkLoading() => _isLoading;
  RxDouble checkLatitude() => _latitude;
  RxDouble checkLongitude() => _longitude;

  late StreamSubscription<User?> user;
  @override
  void onInit() {

    getLocation2().then((val){
      user = FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          Get.off(()=>const LoginScreen());
          print('...........................User is currently signed out!');
        } else {
          String firebaseNumber = user.phoneNumber!.toString();
          Get.off(()=> HomeScreen(number: firebaseNumber.substring(3, firebaseNumber.length)));
          print('+++++++++++++++++++++++++++++User is signed in!');
        }
      });
      // Get.off(()=>const LoginScreen());
    });

    super.onInit();
  }

  getLocation2() async{
    // Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

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
    _isLoading.value = false;

    // _locationData = await loc.Location.instance.getLocation();
    // print('%%%%%%%%%%%%backgroundLocation++++++ ${_locationData}');
  }


// getLocation() async{
  //   bool isServiceEnabled;
  //   geo.LocationPermission locationPermission;
  //
  //   isServiceEnabled = await geo.Geolocator.isLocationServiceEnabled();
  //
  //   //return if service is enabled
  //   if(!isServiceEnabled) {
  //     await geo.Geolocator.openLocationSettings();
  //     return Future.error('Location Not Enabled');
  //   }
  //
  //   //status of permission
  //   locationPermission = await geo.Geolocator.checkPermission();
  //
  //   if(locationPermission == geo.LocationPermission.deniedForever) {
  //     return Future.error('Location Permission Are Denied Forever');
  //   }
  //   else if(locationPermission == geo.LocationPermission.denied) {
  //
  //     //request Permission
  //     locationPermission = await geo.Geolocator.requestPermission();
  //     if(locationPermission == geo.LocationPermission.denied) {
  //       return Future.error('Location Permission Denied');
  //     }
  //
  //   }
  //
  //   // var position = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
  //   // print('+++++++++${position}');
  //   //
  //   // List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
  //   // print(placemark);
  //   // // var lastPosition = await geo.Geolocator.getLastKnownPosition();
  //   // // print('##############${lastPosition}');
  //
  //   _isLoading.value = false;
  //
  //
  // }


}

