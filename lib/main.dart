import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ops/screen/homeScreen/controller/home_screen_controller.dart';
import 'package:ops/navigation/route_constants.dart';
import 'package:ops/navigation/router.dart';
import 'package:ops/util/function.dart';
import 'package:ops/util/sms/smsReceiver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:telephony/telephony.dart' as tel;

void backgroundFetchHeadlessTask(HeadlessTask task) async {
  var taskId = task.taskId;
  bool isTimeout = task.timeout;
  // if (isTimeout) {
  //   // This task has exceeded its allowed running-time.
  //   // You must stop what you're doing and immediately .finish(taskId)
  //   print("[BackgroundFetch] Headless task timed-out: $taskId");
  //   BackgroundFetch.finish(taskId);
  //   return;
  // }
  // print('[BackgroundFetch] Headless event received.');
  // // Do your work here...
  // BackgroundFetch.finish(taskId);

  if (taskId == 'your_task_id') {
    print('0000000000---------00000000your_task_id');
    print(
        '[BackgroundFetch] 0000000000---------0000000000Headless event received.');
    // await HomeScreenController().testing();
    //TODO: perform tasks like — call api, DB and local notification etc…
  }

  if (isTimeout) {
    print("[BackgroundFetch] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
  }
}

//receiving background message
// backgrounMessageHandler(tel.SmsMessage message)  async {
//   print('backgound message handle ----Sender Name: ${message.address}'); //+977981******67, sender nubmer
//   print('backgound message handle ----Body: ${message.body}'); //sms text
//
//   String? Senderno = message.address; //sender number
//   print('i am senderNo. ${Senderno}');
//   String? Body = message.body;
//
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.reload();
//   String? savedNumber = prefs.getString('number');
//   String Message = "Sender Name: ${message.address} \n Body: $Body"; //Sender number and Message body
//   String mobileNumber = '+91${savedNumber}';
//   print('odododododod Saved Number From MAIN.dart ${savedNumber}');
//
//   // CommonFunctions functionController = CommonFunctions();
//   List place = [
//     'i',
//     'am',
//     'post',
//     'api',
//     'response',
//     '$Message',
//   ];
//   double nu = 8888888;
//   // await CommonFunctions().postGeoLocation(savedNumber ?? '', nu, place);
//   await HomeScreenController().sendSms(Senderno, Body);
//   print("DATA SENT TO API");
//   // MethodChannel platform = const MethodChannel("tyre.plex");
//   // await platform.invokeMethod(
//   //   "sendsms",
//   //   <String, dynamic>{
//   //     "phone": mobileNumber,
//   //     "msg": Message,
//   //   },
//   // );
//
//   // tel.Telephony.backgroundInstance.sendSms(to: '$Number', message: '$Message');
//   //  HomeScreenController().sendSms(Senderno, Body);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  await Firebase.initializeApp();
  SmsReceiver().initReceiver();
  await HomeScreenController().startService();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
    initPlatformState().then((value) => print('started'));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 1,
          forceAlarmManager: false,
          stopOnTerminate: false,
          startOnBoot: true,
          enableHeadless: true,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresStorageNotLow: false,
          requiresDeviceIdle: false,
          requiredNetworkType: NetworkType.NONE,
        ), (String taskId) async {
      print("[BackgroundFetch] Event received $taskId");
      // await HomeScreenController().testing();
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {
      print("[BackgroundFetch] TASK TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });

    print('[BackgroundFetch] configure success: $status');

    BackgroundFetch.scheduleTask(
      TaskConfig(
        taskId: 'your_task_id',
        delay: 1000,
        periodic: true,
        forceAlarmManager: false,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext, Orientation, DeviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TyrePlex Ops',
        initialRoute: SplashScreenRoute,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
