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

  Future<void> _startSmsReceiver() async {
    print('I am inside start sms receiver !!!!!!!!!!!!!!!!!!');
    const platform = const MethodChannel('tyre.plex');
    try {
      final result = await platform.invokeMethod('startSmsReceiver');
      print('i am start sms receiver result fo HOME &&&&&&&&& ${result}');
    } on PlatformException catch (e) {
      print("Failed to invoke method: '${e.message}'.");
    }
  }

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
    super.initState();
  }
  @override
  void dispose() {
    homeController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  // static const platform = const MethodChannel('tyre.plex');
  HomeScreenController homeController = Get.put(HomeScreenController());
  TextEditingController phoneController = TextEditingController();
  final prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
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
                autofocus: true,
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
                await saveNumber(phoneController.text);
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
