import 'package:get_it/get_it.dart';

import '../bloc/connectivity_bloc/connectivity_bloc.dart';
import '../bloc/splash_bloc/splash_bloc.dart';
import '../bloc/voice_bloc/voice_bloc.dart';
import '../bloc/weather_bloc/weather_bloc.dart';


final sl = GetIt.instance;

void initDI() {
  sl.registerFactory<SplashBloc>(() => SplashBloc());
  sl.registerFactory<WeatherBloc>(() => WeatherBloc());
  sl.registerFactory<VoiceBloc>(() => VoiceBloc());
  sl.registerSingleton<ConnectivityBloc>(ConnectivityBloc());
}
