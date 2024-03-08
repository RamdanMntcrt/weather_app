import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../../resources/utils/string_constants.dart';

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

    String? city = placeMark[0].locality;

    return city ?? 'Kerala';
  }
}
