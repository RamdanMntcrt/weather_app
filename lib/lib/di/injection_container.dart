import 'package:get_it/get_it.dart';
import 'package:weather_app/lib/bloc/splash_bloc/splash_bloc.dart';
import 'package:weather_app/lib/bloc/weather_bloc/weather_bloc.dart';

final sl = GetIt.instance;

void initDI() {
  sl.registerFactory<SplashBloc>(() => SplashBloc());
  sl.registerFactory<WeatherBloc>(() => WeatherBloc());
}
