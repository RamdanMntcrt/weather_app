import 'dart:developer';

String? getIcon(String? weather) {
  log(weather!);

  if (weather.isEmpty) return 'assets/png/sunny.png';

  switch (weather.toLowerCase()) {
    case 'rain':
    case 'drizzle':
    case 'shower rain':
    case 'thunderstorm':
      return 'assets/png/rain.png';

    case 'mist':
    case 'clouds':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/png/cloudy.png';

    case 'clear':
      return 'assets/png/sunny.png';

    default:
      return 'assets/png/sunny.png';
  }
}