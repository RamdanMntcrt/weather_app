import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/lib/bloc/weather_bloc/weather_bloc.dart';
import 'package:weather_app/lib/presentation/widgets/custom_error_widget.dart';

import '../../../data/models/weather_model.dart';
import '../../../di/injection_container.dart';
import '../../../resources/utils/color_constants.dart';
import '../../../resources/weather_image_widget.dart';
import '../../widgets/loading_widget.dart';
import '../home_screen/components/glass_tile.dart';
import '../home_screen/components/info_tile.dart';

class WeatherSearchScreen extends StatefulWidget {
  final String cityName;

  const WeatherSearchScreen({super.key, required this.cityName});

  @override
  State<WeatherSearchScreen> createState() => _WeatherSearchScreenState();
}

class _WeatherSearchScreenState extends State<WeatherSearchScreen> {
  WeatherBloc? weatherBloc;
  WeatherModel? weatherModel;

  List<String>? title, icons, values;

  String? city, desc, icon;
  double? temp;
  List<String> weatherData = [];

  @override
  void initState() {
    weatherBloc = sl.get<WeatherBloc>();

    weatherBloc!.add(SearchWeatherET(cityName: widget.cityName));
    weatherModel = WeatherModel();
    city = 'Unknown City';
    desc = '';
    icon = 'assets/png/sunny.png';
    temp = 0;
    title = ['Hum', 'Wind', 'Sun Rise', 'Sun Set'];
    icons = [
      'assets/png/humidity.png',
      'assets/png/wind.png',
      'assets/png/sunrise.png',
      'assets/png/sunset.png'
    ];
    values = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherBloc, WeatherState>(
      bloc: weatherBloc,
      listener: (context, state) {
        if (state is WeatherLoadingST) {
          if (state.isLoading == true) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => LoadingWidget(
                      title: 'Fetching weather from ${widget.cityName}',
                    ));
          } else if (state.isLoading == false) {
            Navigator.of(context).pop();
          }
        }

        if (state is WeatherErrorST) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return CustomErrorWidget(title: state.msg);
              });
        }
      },
      buildWhen: (p, c) => c is CurrentWeatherLoadedST,
      builder: (context, state) {
        if (state is CurrentWeatherLoadedST) {
          weatherModel = state.weatherModel;
          desc = weatherModel!.weather![0].main;
          city = weatherModel!.name!;
          temp = weatherModel!.main!.temp! - 273.15;
          icon = getIcon(weatherModel!.weather![0].main!)!;
          weatherData = state.weatherData;
        }

        return Scaffold(
          backgroundColor: ClrConst.accentColor1,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.sp),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ClrConst.blackClr),
                            child: Padding(
                              padding: EdgeInsets.all(6.sp),
                              child: Icon(
                                CupertinoIcons.back,
                                color: ClrConst.whiteClr,
                                size: 28,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 50.h,
                          ),
                          Column(
                            children: [
                              Center(
                                child: FittedBox(
                                  child: WeatherWidget(
                                      icon: icon!,
                                      temp: temp!.toStringAsFixed(1),
                                      city: city!,
                                      desc: desc!),
                                ),
                              ),
                              SizedBox(height: 50.sp),
                              weatherData.isNotEmpty
                                  ? SizedBox(
                                      height: 217.h,
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
                                  : const SizedBox(),
                              SizedBox(height: 70.sp),
                              const Text(
                                  'Note: The api does not provide weather from all cities')
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
