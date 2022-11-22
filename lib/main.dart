import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ops/modules/homeScreen/controller/home_screen_controller.dart';
import 'package:ops/navigation/route_constants.dart';
import 'package:ops/navigation/router.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackground = "fetchBackground";
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        print('I am work Manager..........');
       await HomeScreenController().getLocation2();
        break;
    }
    return Future.value(true);
  });
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: kDebugMode,
  );
  await Workmanager().registerPeriodicTask(
    "1",
    fetchBackground,
    frequency: Duration(minutes: 1),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );
  runApp(const MyApp());
   // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask); //background_fetch
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    // We don't need it anymore since it will be executed in background
    //this._getUserPosition();
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );


    Workmanager().registerPeriodicTask(
      "1",
      fetchBackground,
      frequency: Duration(seconds: 60),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (BuildContext, Orientation, DeviceType) =>
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TyrePlex Ops',
          initialRoute: SplashScreenRoute,
          onGenerateRoute: onGenerateRoute,
        ),
    );
  }
}

