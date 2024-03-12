import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../bloc/voice_bloc/voice_bloc.dart';
import '../../../bloc/weather_bloc/weather_bloc.dart';
import '../../../data/models/weather_model.dart';
import '../../../di/injection_container.dart';
import '../../../resources/utils/color_constants.dart';
import '../../../resources/utils/string_constants.dart';
import '../../../resources/weather_image_widget.dart';
import '../../widgets/custom_error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/voice_bottom_sheet.dart';
import 'components/glass_tile.dart';
import 'components/info_tile.dart';
import 'components/search_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherBloc? weatherBloc;
  VoiceBloc? voiceBloc;
  WeatherModel? weatherModel;

  List<String>? title, icons, values;

  TextEditingController? searchController;

  String? city, desc, icon;
  double? temp;
  List<String> weatherData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    weatherBloc = sl<WeatherBloc>();
    _checkCurrentWeather();

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
    voiceBloc = sl<VoiceBloc>();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => voiceBloc!,
      child: BlocConsumer<WeatherBloc, WeatherState>(
        bloc: weatherBloc,
        listener: (context, state) {
          if (state is WeatherLoadingST) {
            if (state.isLoading == true) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => const LoadingWidget(
                        title: 'Fetching weather ',
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
                  return CustomErrorWidget(
                    title: state.msg,
                    page: StrConst.homeScreen,
                  );
                });
          }
        },
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
              child: RefreshIndicator(
                onRefresh: () async {
                  _refresh();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        SearchTile(
                          searchController: searchController!,
                          onVoiceInput: () async {
                            voiceBloc!.add(ListenToVoiceET());
                            await showModalBottomSheet(
                                isDismissible: false,
                                backgroundColor:
                                    ClrConst.blackClr.withOpacity(0.7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(24.sp),
                                    topRight: Radius.circular(24.sp),
                                  ),
                                ),
                                context: context,
                                builder: (bottomContext) {
                                  return BlocListener<VoiceBloc, VoiceState>(
                                    bloc: voiceBloc,
                                    listener: (context, state) {
                                      if (state is VoiceErrorST) {
                                        Navigator.pop(bottomContext);
                                        Fluttertoast.showToast(
                                            msg: 'Did not hear any voice');
                                      }
                                      if (state is VoiceTextLoadedST) {
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          if (state.text.isNotEmpty) {
                                            Navigator.pop(bottomContext);
                                            Navigator.pushNamed(
                                                context, StrConst.searchScreen,
                                                arguments: state.text.trim());
                                          }
                                        });
                                      }
                                    },
                                    child: BlocBuilder<VoiceBloc, VoiceState>(
                                      bloc: voiceBloc,
                                      buildWhen: (p, c) =>
                                          c is VoiceListeningST ||
                                          c is VoiceTextLoadedST ||
                                          c is VoiceErrorST,
                                      builder: (context, state) {
                                        bool? isListen = false;
                                        String text = '';
                                        if (state is VoiceListeningST) {
                                          isListen = state.isListening;
                                        }
                                        if (state is VoiceTextLoadedST) {
                                          text = state.text;
                                        }
                                        return VoiceBottomSheet(
                                          city: text,
                                          isListening: isListen,
                                        );
                                      },
                                    ),
                                  );
                                });
                          },
                          onSearch: (val) {
                            if (val != StrConst.emptyString) {
                              Navigator.pushNamed(
                                  context, StrConst.searchScreen,
                                  arguments: val.toString().trim());
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'please enter a city',
                                  backgroundColor: ClrConst.redPastel);
                            }
                          },
                        ),
                        Column(
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
                                                      value:
                                                          weatherData[index]);
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      weatherBloc!.add(GetCurrentWeatherET());
    });
  }

  void _checkCurrentWeather() async {
    log('checkCurrentWeather');

    await Future.delayed(const Duration(milliseconds: 500), () {
      weatherBloc!.add(GetCurrentWeatherET());
    });
  }
}
