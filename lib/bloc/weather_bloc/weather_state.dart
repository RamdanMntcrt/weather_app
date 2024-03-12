part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

abstract class WeatherActionState {}

class WeatherInitial extends WeatherState {}

class CurrentWeatherLoadedST extends WeatherState {
  final String city;
  final WeatherModel weatherModel;
  final List<String> weatherData;

  CurrentWeatherLoadedST(
      {required this.city,
      required this.weatherModel,
      required this.weatherData});
}

class WeatherSearchedST extends WeatherState {}

class WeatherLoadingST extends WeatherState {
  final bool isLoading;

  WeatherLoadingST({required this.isLoading});
}

class WeatherConnectionSuccessST extends WeatherState {}

class WeatherErrorST extends WeatherState {
  final String msg;

  WeatherErrorST({required this.msg});
}

class SearchVoiceActionST extends WeatherState {}

class WeatherClearST extends WeatherState {}

class WeatherNavigateST extends WeatherState {}
