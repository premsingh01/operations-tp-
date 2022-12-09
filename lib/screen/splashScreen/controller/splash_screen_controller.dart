import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:ops/screen/homeScreen/controller/home_screen_controller.dart';
import 'package:ops/screen/homeScreen/view/home_screen.dart';
import 'package:ops/screen/login/view/login_screen.dart';
import 'package:permission_handler/permission_handler.dart' as per;

class SplashScreenController extends GetxController {
  late StreamSubscription<User?> user;
  @override
  void onInit() {
    HomeScreenController().getBatteryOptimizationPermission();
    // getBatteryOptimizationPermission();
    getLocationPermission().then((val) {
      user = FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          Get.off(() => const LoginScreen());
          print('...........................User is currently signed out!');
        } else {
          String firebaseNumber = user.phoneNumber!.toString();
          Get.off(() => HomeScreen(
              number: firebaseNumber.substring(3, firebaseNumber.length)));
          print('+++++++++++++++++++++++++++++User is signed in!');
        }
      });
    });

    super.onInit();
  }

  // getBatteryOptimizationPermission() async{
  //   var status = await per.Permission.ignoreBatteryOptimizations;
  //   if(await status.isPermanentlyDenied){
  //     print('Battery Optimization is permenantly denied');
  //   }
  //   if(await status.isRestricted || await status.isDenied){
  //     per.Permission.ignoreBatteryOptimizations.request();
  //   }
  //
  //   per.Permission.ignoreBatteryOptimizations.isGranted;
  //   return;
  // }

  getLocationPermission() async {
      var locationStatus = per.Permission.sms;
      if (await locationStatus.isPermanentlyDenied) {
        print('Sms permission is permenantly denied');
        per.Permission.location.request();
      }
      if (await locationStatus.isRestricted || await locationStatus.isDenied) {
        per.Permission.location.request();
      }

      per.Permission.location.isGranted;
      return;

    //location library
    // Location location = new Location();

    // bool _serviceEnabled;
    // loc.PermissionStatus _permissionGranted;
    //
    // loc.Location.instance.enableBackgroundMode(enable: true);
    //
    // _serviceEnabled = await loc.Location.instance.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await loc.Location.instance.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }
    //
    // _permissionGranted = await loc.Location.instance.hasPermission();
    // if (_permissionGranted == loc.PermissionStatus.denied) {
    //   _permissionGranted = await loc.Location.instance.requestPermission();
    //   if (_permissionGranted != loc.PermissionStatus.granted) {
    //     return;
    //   }
    // }
  }
  // if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
  //   Intent intent = new Intent();
  //   String packageName = 'com.tyreplex.ops';
  //   PowerManager pm = (PowerManager) getSystemService(POWER_SERVICE);
  //   if (!pm.isIgnoringBatteryOptimizations(packageName)) {
  //     intent.setAction(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
  //     intent.setData(Uri.parse("package:" + packageName));
  //     startActivity(intent);
  //   }
  // }

  //}

// getLocation() async{
//     bool isServiceEnabled;
//     geo.LocationPermission locationPermission;
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
//     // var position = await geo.Geolocator.getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
//     // print('+++++++++${position}');
//     //
//     // List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);
//     // print(placemark);
//     // // var lastPosition = await geo.Geolocator.getLastKnownPosition();
//     // // print('##############${lastPosition}');
//
//     _isLoading.value = false;
//
//
//   }

}
