import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:weather_app/lib/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/lib/data/models/weather_model.dart';
import 'package:weather_app/lib/presentation/screens/home_screen/components/glass_tile.dart';
import 'package:weather_app/lib/presentation/screens/home_screen/components/info_tile.dart';
import 'package:weather_app/lib/presentation/widgets/strect_scaffold_widget.dart';
import 'package:weather_app/lib/resources/utils/color_constants.dart';

import '../../../di/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherBloc? weatherBloc;
  WeatherModel? weatherModel;

  List<String>? title, icons, values;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherBloc = sl<WeatherBloc>();
    weatherBloc!.add(GetCurrentWeatherET());
    weatherModel = WeatherModel();
    title = ['Hum', 'Wind', 'Sun Rise', 'Sun Set'];
    icons = [
      'assets/png/humidity.png',
      'assets/png/wind.png',
      'assets/png/sunrise.png',
      'assets/png/sunset.png'
    ];
    values = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => weatherBloc!,
      child: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {},
        child: BlocBuilder<WeatherBloc, WeatherState>(
          bloc: weatherBloc,
          buildWhen: (p, c) =>
              c is CurrentWeatherLoadedST || c is WeatherLoadingST,
          builder: (context, state) {
            if (state is WeatherLoadingST) {
              if (state.isLoading == true) {
                return Scaffold(
                  backgroundColor: ClrConst.accentColor1,
                  body: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Fetching Weather',
                            style: TextStyle(fontSize: 24.sp),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const CupertinoActivityIndicator()
                      ],
                    ),
                  ),
                );
              }
            }

            if (state is CurrentWeatherLoadedST) {
              return StretchScaffold(
                child: Scaffold(
                  backgroundColor: ClrConst.accentColor1,
                  body: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        BlocBuilder<WeatherBloc, WeatherState>(
                          buildWhen: (p, c) => c is CurrentWeatherLoadedST,
                          bloc: weatherBloc,
                          builder: (context, state) {
                            String? city = 'Unknown City';
                            String? desc = '';
                            double? temp = 0;
                            String? icon = 'assets/png/sunny.png';
                            List<String> weatherData = [];

                            if (state is CurrentWeatherLoadedST) {
                              weatherModel = state.weatherModel;
                              desc = weatherModel!.weather![0].main;
                              city = weatherModel!.name!;
                              temp = weatherModel!.main!.temp! - 273.15;
                              icon = getIcon(weatherModel!.weather![0].main!)!;
                              weatherData = state.weatherData;
                            }

                            return Column(
                              children: [
                                Center(
                                  child: FittedBox(
                                    child: WeatherWidget(
                                        icon: icon,
                                        temp: temp.toStringAsFixed(1),
                                        city: city,
                                        desc: desc!),
                                  ),
                                ),
                                SizedBox(height: 50.sp),
                                SizedBox(
                                  height: 200.h,
                                  child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return InfoTile(
                                                title: title![index],
                                                icon: icons![index],
                                                value: weatherData[index]);
                                          })
                                      .animate()
                                      .scale(
                                          duration: const Duration(
                                              milliseconds: 700)),
                                )
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Future<String> getCurrentTime() async {
    var now = DateTime.now();
    var formattedTime = DateFormat.jm().format(now);
    return formattedTime;
  }

  String? getIcon(String? weather) {
    log(weather!);

    if (weather == null) return 'assets/png/sunny.png';

    switch (weather.toLowerCase()) {
      case 'rain':
      case 'drizzle':
      case 'shower rain':
      case 'thunderstorm':
        return 'assets/png/rain.png';

      case 'mist':
      case 'clouds':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/png/cloudy.png';

      case 'clear':
        return 'assets/png/sunny.png';

      default:
        return 'assets/png/sunny.png';
    }
  }
}
