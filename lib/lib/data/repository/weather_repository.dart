import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepo {
  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    log(placeMark.toString());

    String? city = placeMark[0].locality;

    return city ?? 'Kerala';
  }
}
