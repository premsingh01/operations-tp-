import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import 'package:ops/screen/homeScreen/controller/home_screen_controller.dart';
import 'package:ops/screen/homeScreen/view/home_screen.dart';
import 'package:ops/screen/login/view/login_screen.dart';

import '../../../util/permission.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() async {
    Permission().getLocationPermission().then((value) => signedInCheck());
    // signedInCheck();
    super.onInit();
  }

  signedInCheck() {
    late StreamSubscription<User?> user;
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
  }
}
