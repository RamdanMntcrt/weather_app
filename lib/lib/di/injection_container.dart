import 'package:get_it/get_it.dart';
import 'package:weather_app/lib/bloc/splash_bloc/splash_bloc.dart';

final sl = GetIt.instance;

void initDI() {
  sl.registerFactory<SplashBloc>(() => SplashBloc());
}
