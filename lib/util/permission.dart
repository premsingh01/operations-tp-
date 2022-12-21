import 'package:permission_handler/permission_handler.dart' as per;




class Permission {

  getLocationPermission() async {
    var locationStatus = per.Permission.locationAlways;
    if (await locationStatus.isPermanentlyDenied) {
      print('Location permission is permanently denied');
      per.Permission.location.request();
    }
    if (await locationStatus.isRestricted || await locationStatus.isDenied) {
      per.Permission.location.request();
    }
    per.Permission.location.isGranted;
  }

  getBatteryOptimizationPermission() async {
    var batteryStatus = per.Permission.ignoreBatteryOptimizations;
    if (await batteryStatus.isPermanentlyDenied) {
      print('Battery Optimization is permenantly denied');
      per.Permission.ignoreBatteryOptimizations.request();
    }
    if (await batteryStatus.isRestricted || await batteryStatus.isDenied) {
      per.Permission.ignoreBatteryOptimizations.request();
    }
    per.Permission.ignoreBatteryOptimizations.isGranted;
  }

  // getSmsPermission() async {
  //   var smsStatus = per.Permission.sms;
  //   if (await smsStatus.isPermanentlyDenied) {
  //     print('Sms permission is permanently denied');
  //     per.Permission.sms.request();
  //   }
  //   if (await smsStatus.isRestricted || await smsStatus.isDenied) {
  //     per.Permission.sms.request();
  //   }
  //   per.Permission.sms.isGranted;
  // }
  Future<bool> getSmsPermission() async {
    if (await per.Permission.sms.status == per.PermissionStatus.granted) {
      return true;
    } else if(await per.Permission.sms.status.isRestricted || await per.Permission.sms.status.isDenied || await per.Permission.sms.status.isPermanentlyDenied) {
      per.Permission.sms.request();
      if (await per.Permission.sms.request() == per.PermissionStatus.granted) {
        return true;
      }
    }
    return false;
    }

getAllPermission() async {
  Map<per.Permission, per.PermissionStatus> statuses = await [
    per.Permission.location,
    per.Permission.ignoreBatteryOptimizations,
    // per.Permission.sms
  ].request();

  if ((statuses[per.Permission.location]?.isDenied) ?? false) {
    print('location refused');
  }
  if ((statuses[per.Permission.ignoreBatteryOptimizations]?.isDenied) ?? false) {
    print('battery optimization permission refused');
  }
  // if ((statuses[per.Permission.sms]?.isDenied) ?? false) {
  //   print('sms refused');
  // }
}
  }



