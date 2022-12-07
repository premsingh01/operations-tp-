import 'package:flutter/material.dart';
import 'package:ops/screen/homeScreen/view/home_screen.dart';
import 'package:ops/screen/login/view/login_screen.dart';
import 'package:ops/screen/login/view/otp_screen.dart';
import 'package:ops/screen/setting/view/setting_screen.dart';
import 'package:ops/screen/splashScreen/view/splash_screen.dart';
import 'route_constants.dart' as route;

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case route.LoginRoute:
      return MaterialPageRoute(builder: (_) => LoginScreen());

    case route.HomeScreenRoute:
      String? argument;
      if (settings.arguments is String) {
        argument = settings.arguments as String;
      }
      return MaterialPageRoute(
          builder: (_) => HomeScreen(number: argument ?? ''));

    case route.OtpRoute:
      String? argument;
      if (settings.arguments is String) {
        argument = settings.arguments as String;
      }
      return MaterialPageRoute(
          builder: (_) => OtpScreen(mobileNumber: argument ?? ''));

    case route.SplashScreenRoute:
      return MaterialPageRoute(builder: (_) => SplashScreen());

    case route.SettingScreenRoute :
      return MaterialPageRoute(builder: (_) => SettingScreen());
  }
}
