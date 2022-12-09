import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ops/screen/homeScreen/controller/home_screen_controller.dart';
import 'package:ops/screen/splashScreen/controller/splash_screen_controller.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController splashController = Get.put(SplashScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // void _navigateToHome() {
  //   Navigator.pushReplacementNamed(context, LoginRoute);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Image.asset(
          'assets/logo.jpg',
          height: 8.h,
        )),
      ),
    );
  }
}
