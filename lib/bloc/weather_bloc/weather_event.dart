part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetCurrentWeatherET extends WeatherEvent {}

class SearchWeatherET extends WeatherEvent {
  final String cityName;

  SearchWeatherET({required this.cityName});
}


