import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ops/navigation/route_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key, required this.mobileNumber}) : super(key: key);
  final String mobileNumber;

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String? buildNo;
  String? ver;

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, LoginRoute, (route) => false);
  }

  @override
  void initState() {
    getAppVersion();

    // TODO: implement initState
    super.initState();
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    buildNo = packageInfo.buildNumber;
    ver = packageInfo.version;
    setState(() {});
    // print("___________${buildNo}");
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth instance = FirebaseAuth.instance;
    var phoneNUmber = instance.currentUser?.phoneNumber?.substring(3, 13);
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 8.5.h,
              color: Colors.red,
              child: ListTile(
                title: const Text(
                  'Howdy User!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '${phoneNUmber}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Image.asset(
                  'assets/drawer_img.jpg',
                  height: 4.h,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 6.h,
                    child: ListTile(
                      leading: Icon(Icons.pages),
                      title: const Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, HomeScreenRoute);
                      },
                    ),
                  ),
                  Container(
                    height: 6.h,
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        Navigator.popAndPushNamed(context, SettingScreenRoute);
                      },
                    ),
                  ),
                  Container(
                    height: 6.h,
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: const Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        logout();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 10.h,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/logo.jpg',
                      height: 5.h,
                    ),
                    Text(
                      '${ver} Build ${buildNo}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
