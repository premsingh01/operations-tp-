import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ops/api/api_client.dart';

class LocationRepo{
  Future<void> sendLocation(Position location,List<Placemark> placemark)async {
    try {
      Dio dio = ApiClient().init();
      Response r = await dio.post('/products',data: {
        "lat":location.latitude,
        "long":location.longitude,
        "address": placemark,
      });
    } on Exception catch (e) {
      Future.error(e);
    }
  }
}