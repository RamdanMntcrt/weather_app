import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/lib/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/lib/presentation/widgets/glass_tile.dart';
import 'package:weather_app/lib/resources/utils/color_constants.dart';

import '../../../di/injection_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherBloc? weatherBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherBloc = sl<WeatherBloc>();
    weatherBloc!.add(GetCurrentWeatherET());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => weatherBloc!,
      child: BlocListener<WeatherBloc, WeatherState>(
        listener: (context, state) {},
        child: Scaffold(
          backgroundColor: ClrConst.accentColor1,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<WeatherBloc, WeatherState>(
                  buildWhen: (p, c) =>
                      c is CurrentWeatherLoadedST || c is WeatherLoadingST,
                  bloc: weatherBloc,
                  builder: (context, state) {
                    String? city = 'City';

                    if (state is CurrentWeatherLoadedST) {
                      city = state.weatherModel.name!;
                    }

                    return WeatherWidget(
                        weather: city,
                        desc:
                            'sda'); /*Column(
                      children: [
                        Center(
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              city,
                              style: TextStyle(fontSize: 28.sp),
                            ),
                          ),
                        )
                      ],
                    );*/
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getCurrentTime() async {
    var now = DateTime.now();
    var formattedTime = DateFormat.jm().format(now);
    return formattedTime;
  }
}
