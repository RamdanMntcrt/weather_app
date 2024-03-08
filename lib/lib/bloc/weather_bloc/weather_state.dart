part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

abstract class WeatherActionState {}

class WeatherInitial extends WeatherState {}

class CurrentWeatherLoadedST extends WeatherState {}

class WeatherSearchedST extends WeatherState {}

class WeatherLoadingST extends WeatherState {
  final bool isLoading;

  WeatherLoadingST({required this.isLoading});
}

class WeatherConnectionSuccessState extends WeatherState {}

class WeatherConnectionErrorState extends WeatherState {
  final String msg;

  WeatherConnectionErrorState({required this.msg});
}

class SearchVoiceActionST extends WeatherState {}
