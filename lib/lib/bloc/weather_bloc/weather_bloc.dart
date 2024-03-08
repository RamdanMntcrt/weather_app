import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/lib/data/repository/weather_repository.dart';
import 'package:weather_app/lib/resources/utils/string_constants.dart';

part 'weather_event.dart';

part 'weather_state.dart';

WeatherFactory? wf;
String? _cityName;
WeatherRepo weatherRepo = WeatherRepo();

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
      final weather = await wf!.currentWeatherByCityName(_cityName!);

      log(weather.toString());
    } catch (e) {
      log(e.toString());
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
