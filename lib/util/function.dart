import 'dart:async';

import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class CommonFunctions {
  double _latitude = 0;
  double _longitude = 0;
  List<Placemark> placemark = [];

  Future<LocationAndAddress> getGeolocation() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;
    loc.LocationData _locationData;

    loc.Location.instance.enableBackgroundMode(enable: true);

    _serviceEnabled = await loc.Location.instance.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await loc.Location.instance.requestService();
      // if (!_serviceEnabled) {
      //   return;
      // }
    }

    _permissionGranted = await loc.Location.instance.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await loc.Location.instance.requestPermission();
      // if (_permissionGranted != loc.PermissionStatus.granted) {
      //   return ;
      // }
    }

    _locationData = await loc.Location.instance.getLocation();
    _latitude = _locationData.latitude!;
    _longitude = _locationData.longitude!;

    placemark = await placemarkFromCoordinates(_latitude, _longitude);

    return LocationAndAddress(_latitude, _longitude, placemark);
  }
 //string ko double me change krna h
  postGeoLocation(String latitude, double longitude, List placemark) async {
    var dio = Dio();
    try {
      var response = await dio.post('https://fakestoreapi.com/products', data: {
        "lat": latitude,
        "long": longitude,
        "address": placemark,
      });
      print(response.data);
      print(response.requestOptions.data);
    } on Exception catch (e) {
      Future.error(e);
    }
  }
}

class LocationAndAddress {
  final double latitude;
  final double longitude;
  final List<Placemark> placemark;
  LocationAndAddress(this.latitude, this.longitude, this.placemark);
}
