import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';

import '../../data/models/weather_model.dart';
import '../../data/repository/weather_repository.dart';
import '../../resources/utils/string_constants.dart';

part 'weather_event.dart';

part 'weather_state.dart';

WeatherFactory? wf;
String? _cityName;
WeatherRepo weatherRepo = WeatherRepo();

List<String> weatherInfoList = [];

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    // _initializeLocation();
    on<GetCurrentWeatherET>(getCurrentWeatherMethod);
    on<SearchWeatherET>(searchWeatherMethod);
  }

  void _initializeLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
  }

  FutureOr<void> getCurrentWeatherMethod(
      GetCurrentWeatherET event, Emitter<WeatherState> emit) async {
    WeatherModel? weatherModel;
    emit(WeatherLoadingST(isLoading: true));
    try {
      wf = WeatherFactory(StrConst.apiKey, language: Language.ENGLISH);
      _cityName = await weatherRepo.getCurrentCity();
      Weather weather = await wf!.currentWeatherByCityName(_cityName!);

      if (weather.areaName != null) {
        var n = json.encode(weather);
        log(n);
        weatherModel = weatherModelFromJson(n);

        int humidity = weatherModel.main!.humidity!;
        double windSpeed = weatherModel.wind!.speed!;
        int sunrise = weatherModel.sys!.sunrise!;
        int sunset = weatherModel.sys!.sunset!;

        String formattedSunrise = DateFormat.jm()
            .format(DateTime.fromMillisecondsSinceEpoch(sunrise * 1000));
        String formattedSunset = DateFormat.jm()
            .format(DateTime.fromMillisecondsSinceEpoch(sunset * 1000));

        weatherInfoList = [
          '$humidity %',
          '$windSpeed m/s',
          formattedSunrise,
          formattedSunset,
        ];
      }

      emit(WeatherLoadingST(isLoading: false));
      emit(CurrentWeatherLoadedST(
          city: _cityName!,
          weatherModel: weatherModel!,
          weatherData: weatherInfoList));
    } catch (e) {
      log(e.toString());
      emit(WeatherLoadingST(isLoading: false));
      if (e is SocketException) {
        log('in socket exception');

        emit(
            WeatherErrorST(msg: 'Make sure you are connected to the internet'));
      }
    }
  }

  FutureOr<void> searchWeatherMethod(
      SearchWeatherET event, Emitter<WeatherState> emit) async {
    WeatherModel? weatherModel;

    emit(WeatherLoadingST(isLoading: true));

    try {
      await Future.delayed(const Duration(milliseconds: 3000));
      wf = WeatherFactory(StrConst.apiKey, language: Language.ENGLISH);

      Weather weather = await wf!.currentWeatherByCityName(event.cityName);

      if (weather.areaName != null) {
        var n = json.encode(weather);
        log(n);
        weatherModel = weatherModelFromJson(n);

        int humidity = weatherModel.main!.humidity!;
        double windSpeed = weatherModel.wind!.speed!;
        int sunrise = weatherModel.sys!.sunrise!;
        int sunset = weatherModel.sys!.sunset!;

        String formattedSunrise = DateFormat.jm()
            .format(DateTime.fromMillisecondsSinceEpoch(sunrise * 1000));
        String formattedSunset = DateFormat.jm()
            .format(DateTime.fromMillisecondsSinceEpoch(sunset * 1000));

        // Create a list of strings
        weatherInfoList = [
          '$humidity %',
          '$windSpeed m/s',
          formattedSunrise,
          formattedSunset,
        ];
      }

      emit(WeatherLoadingST(isLoading: false));
      emit(CurrentWeatherLoadedST(
          city: _cityName!,
          weatherModel: weatherModel!,
          weatherData: weatherInfoList));
    } catch (e) {
      emit(WeatherLoadingST(isLoading: false));
      if (e is OpenWeatherAPIException) {
        emit(WeatherErrorST(msg: StrConst.cityNotFount));
      }
      if (e is SocketException) {
        emit(
            WeatherErrorST(msg: 'Make sure you are connected to the internet'));
      }
      log(e.toString());
    }
  }
}
