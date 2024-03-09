import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/lib/data/models/weather_model.dart';
import 'package:weather_app/lib/data/repository/weather_repository.dart';
import 'package:weather_app/lib/resources/utils/string_constants.dart';

part 'weather_event.dart';

part 'weather_state.dart';

WeatherFactory? wf;
String? _cityName;
WeatherRepo weatherRepo = WeatherRepo();
WeatherModel? weatherModel;
List<String> weatherInfoList = [];

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetCurrentWeatherET>(getCurrentWeatherMethod);
    on<WeatherServiceConnectionET>(weatherConnectionMethod);
  }

  FutureOr<void> getCurrentWeatherMethod(
      GetCurrentWeatherET event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingST(isLoading: true));
    try {
      wf = WeatherFactory(StrConst.apiKey, language: Language.ENGLISH);
      _cityName = await weatherRepo.getCurrentCity();
      Weather weather = await wf!.currentWeatherByCityName(_cityName!);

      if (weather.areaName != null) {
        var n = json.encode(weather);
        log(n);
        weatherModel = weatherModelFromJson(n);
        // Extract required information
        int humidity = weatherModel!.main!.humidity!;
        double windSpeed = weatherModel!.wind!.speed!;
        int sunrise = weatherModel!.sys!.sunrise!;
        int sunset = weatherModel!.sys!.sunset!;

        String formattedSunrise = DateFormat.jm()
            .format(DateTime.fromMillisecondsSinceEpoch(sunrise * 1000));
        String formattedSunset = DateFormat.jm()
            .format(DateTime.fromMillisecondsSinceEpoch(sunset * 1000));

        // Create a list of strings
        weatherInfoList = [
          '$humidity %', // Humidity
          '$windSpeed m/s', // Wind Speed
          formattedSunrise, // Sunrise
          formattedSunset, // Sunset
        ];
      }

      emit(WeatherLoadingST(isLoading: false));
      emit(CurrentWeatherLoadedST(
          city: _cityName!,
          weatherModel: weatherModel!,
          weatherData: weatherInfoList));
    } catch (e) {
      log(_cityName!);
      log(e.toString());
      emit(WeatherLoadingST(isLoading: false));
    }
  }

  FutureOr<void> weatherConnectionMethod(
      WeatherServiceConnectionET event, Emitter<WeatherState> emit) {
    try {
      wf = WeatherFactory(StrConst.apiKey, language: Language.ENGLISH);
    } catch (e) {
      emit(WeatherConnectionErrorState(msg: 'Error connecting to the cloud'));
    }
  }
}
