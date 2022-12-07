import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                ListTile(
                    leading: const Icon(Icons.battery_charging_full_sharp),
                    title: const Text(
                      'Battery Optimization',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onTap: () {
                      AppSettings.openBatteryOptimizationSettings();
                      // openAppSettings();
                    }),
                const Divider(
                  thickness: 0.5,
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
