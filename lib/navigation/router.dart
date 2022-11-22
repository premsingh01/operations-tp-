import 'package:flutter/material.dart';
import 'package:ops/modules/homeScreen/view/home_screen.dart';
import 'package:ops/modules/login/view/login_screen.dart';
import 'package:ops/modules/login/view/otp_screen.dart';
import 'package:ops/modules/splashScreen/view/splash_screen.dart';
import 'route_constants.dart' as route;

Route<dynamic>? onGenerateRoute (RouteSettings settings) {
  switch(settings.name){
    case route.LoginRoute :
      return MaterialPageRoute(builder: (_) => LoginScreen());

    case route.HomeScreenRoute :
      String? argument;
      if(settings.arguments is String) {
        argument = settings.arguments as String;
      }
      return MaterialPageRoute(builder: (_) => HomeScreen(number: argument ??''));

    case route.OtpRoute :
      String? argument;
      if(settings.arguments is String) {
        argument = settings.arguments as String;
      }
      return MaterialPageRoute(builder: (_) => OtpScreen(mobileNumber: argument ??''));

    case route.SplashScreenRoute :
      return MaterialPageRoute(builder: (_) => SplashScreen());
  }
}
