import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ops/api/api_client.dart';

class LocationRepo {
  Future<void> sendLocation(
      double Latitude, double Longitude, List<Placemark> placemark) async {
    try {
      Dio dio = ApiClient().init();
      Response r = await dio.post('/products', data: {
        "lat": Latitude,
        "long": Longitude,
        "address": placemark,
      });

      print('i am location repo0000000000000000000000000000000000000000000000000**${r}');
    } on Exception catch (e) {
      Future.error(e);
    }
  }
}
