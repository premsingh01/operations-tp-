import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ops/screen/homeScreen/controller/home_screen_controller.dart';
import 'package:ops/util/function.dart';
import 'package:ops/util/sms/smsReceiver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../widgets/drawer.dart';
import 'package:permission_handler/permission_handler.dart' as per;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.number}) : super(key: key);
  final String number;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  saveNumber(String mobileNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('number', mobileNumber);
    print('Number saved____________________++++++++');
    final String? savedNumber = prefs.getString('number');
    print(savedNumber);
  }

  // static const platform = const MethodChannel('tyre.plex');
  Future<void> _startService() async {
    const platform = const MethodChannel('tyre.plex');
    try {
      final result = await platform.invokeMethod('startExampleService');
      // setState(() {
      //   _serverState = result;
      // });
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  Future<void> _stopService() async {
    const platform = const MethodChannel('tyre.plex');
    try {
      final result = await platform.invokeMethod('stopExampleService');
      // setState(() {
      //   _serverState = result;
      // });
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // _startService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeScreenController homeController = Get.put(HomeScreenController());
    // SmsReceiver smsReceiver = Get.put(SmsReceiver());
    TextEditingController phoneController = TextEditingController();
    final prefs = SharedPreferences.getInstance();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Home'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: MainDrawer(
        mobileNumber: widget.number,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: TextField(
                controller: phoneController,
                cursorColor: Colors.black,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.red,
                  labelText: 'Mobile Number',
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 1.8),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            ElevatedButton(
              onPressed: () async {
                saveNumber(phoneController.text);
                var smsStatus = per.Permission.sms;
                if (await smsStatus.isPermanentlyDenied ||
                    await smsStatus.isDenied ||
                    await smsStatus.isRestricted) {
                  HomeScreenController().getSmsPermission();
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                child: Text(
                  'Save',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 16,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 0,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            ElevatedButton(
              onPressed: () async {
                _startService();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                child: Text(
                  'Start  Foreground Service',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 16,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 0,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            ElevatedButton(
              onPressed: () async {
                _stopService();
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                child: Text(
                  'Cancel Foreground Service',
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 16,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
