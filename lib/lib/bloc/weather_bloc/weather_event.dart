part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class GetCurrentWeatherET extends WeatherEvent {}

class SearchWeatherET extends WeatherEvent {}

class WeatherServiceConnectionET extends WeatherEvent {
  final String? apiKey;

  WeatherServiceConnectionET({required this.apiKey});
}
