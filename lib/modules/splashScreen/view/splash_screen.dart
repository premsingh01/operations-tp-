import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ops/modules/homeScreen/view/home_screen.dart';
import 'package:ops/modules/splashScreen/controller/splash_screen_controller.dart';
import 'package:ops/navigation/route_constants.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController controller = Get.put(SplashScreenController());

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
           child: Center(child: Image.asset('assets/logo.jpg', height: 8.h,)),
       ),
     );
    // Obx(() => Scaffold(
    //   body: SafeArea(
    //     child: Align(
    //   alignment: Alignment.center,
    //   child: Image.asset('assets/logo.jpg', width: 200, height: 200, fit: BoxFit.fitWidth),
    // )
    //   ),
    // ),
    // );
  }
}
