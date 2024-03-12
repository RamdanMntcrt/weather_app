import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class WeatherRepo {
  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Request location permission if not granted
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Handle case where location permission is not granted
      // You may inform the user about the necessity of location permission
      // and provide instructions on how to enable it in settings
      return 'Unknown City';
    }
    // if (permission == LocationPermission.denied ||
    //     permission == LocationPermission.deniedForever) {
    //   permission = await Geolocator.requestPermission();
    // }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    log(placeMark.toString());

    String? city = placeMark[0].locality;

    return city ?? 'Kerala';
  }
}
