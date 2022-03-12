import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/bloc/course_bloc.dart';
import 'package:flutter_travelcars_driver/src/bloc/weather_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/course_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/weather_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/service_widgets/service_widget.dart';

import '../../../widgets/service_widgets/service_shimmer.dart';
import '../../../widgets/utils_widgets.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  void initState() {
    courseBloc.getAllCourse();
    weatherBloc.getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: courseBloc.courseFeedback,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<CourseModel> data = snapshot.data!;
                  print(data.length);
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                        horizontal: 8 * w, vertical: 16 * h),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21 * h),
                      color: AppTheme.lightGray,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: AppTheme.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Курсы валют",
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 18 * h,
                              height: 1.3 * h,
                              letterSpacing: 0.2,
                              color: AppTheme.black,
                            ),
                          ),
                          SizedBox(
                            height: 16 * h,
                          ),
                          for (int i = 0; i < 3; i++)
                            for (int j = 0; j < data.length; j++)
                              (data[j].code == "USD" && i == 0 ||
                                      data[j].code == "EUR" && i == 1 ||
                                      data[j].code == "RUB" && i == 2)
                                  ? Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 40 * h,
                                                          width: 40 * h,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        24),
                                                            color: data[j]
                                                                        .code ==
                                                                    "USD"
                                                                ? const Color(
                                                                    0xff454563)
                                                                : data[j].code ==
                                                                        "EUR"
                                                                    ? const Color(
                                                                        0xffBE1AF7)
                                                                    : const Color(
                                                                        0xff1276A7),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              data[j].code ==
                                                                      "USD"
                                                                  ? "\$"
                                                                  : data[j].code ==
                                                                          "EUR"
                                                                      ? "€"
                                                                      : "P",
                                                              style: TextStyle(
                                                                fontFamily: AppTheme
                                                                    .fontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize:
                                                                    28 * h,
                                                                letterSpacing:
                                                                    0.7,
                                                                color: AppTheme
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              data[j].title,
                                                              style: TextStyle(
                                                                fontFamily: AppTheme
                                                                    .fontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize:
                                                                    16 * h,
                                                                height: 1.5 * h,
                                                                letterSpacing:
                                                                    0.3,
                                                                color: AppTheme
                                                                    .black,
                                                              ),
                                                            ),
                                                            Text(
                                                              data[j].code,
                                                              style: TextStyle(
                                                                fontFamily: AppTheme
                                                                    .fontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontSize:
                                                                    16 * h,
                                                                height: 1.5 * h,
                                                                letterSpacing:
                                                                    0.3,
                                                                color: AppTheme
                                                                    .black,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    data[j].cbPrice,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontFamily,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 14 * h,
                                                      height: 1.5 * h,
                                                      letterSpacing: 0.3,
                                                      color: AppTheme.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    data[j].date,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontFamily,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 10 * h,
                                                      height: 1.5 * h,
                                                      letterSpacing: 0.3,
                                                      color: AppTheme.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 4 * h,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "ПОКУПКА: ${data[j].nbuBuyPrice}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontFamily,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 12 * h,
                                                    height: 15 / 12 * h,
                                                    letterSpacing: 0.3,
                                                    color: AppTheme.black,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "ПРОДАЖА: ${data[j].nbuCellPrice}",
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.fontFamily,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12 * h,
                                                  height: 15 / 12 * h,
                                                  letterSpacing: 0.3,
                                                  color: AppTheme.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 6 * h,
                                          ),
                                          i != 2 ? MySeparator() : Container(),
                                          SizedBox(
                                            height: 6 * h,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const ServiceShimmer();
                }
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: weatherBloc.weatherFeedBack,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  WeatherModel info = snapshot.data!;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      left: 8 * w,
                      right: 8 * w,
                      bottom: 24 * h,
                    ),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21 * h),
                      color: AppTheme.lightGray,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16 * h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: AppTheme.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Прогноз погоды",
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 18 * h,
                              height: 1.38 * h,
                              letterSpacing: 0.3,
                              color: AppTheme.black,
                            ),
                          ),
                          Text(
                            "Ташкент",
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 12 * h,
                              height: 1.38 * h,
                              letterSpacing: 0.3,
                              color: AppTheme.blue,
                            ),
                          ),
                          Text(
                            "Сегодня, ${Utils.getDateDay(DateTime.now())}",
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              fontSize: 14 * h,
                              height: 1.38 * h,
                              letterSpacing: 0.3,
                              color: AppTheme.blue,
                            ),
                          ),
                          SizedBox(
                            height: 10 * h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80 * h,
                                      width: 100 * h,
                                      child: Image.asset(
                                        'assets/images/weather.png',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        "${info.main.temp.toInt()}°",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontFamily,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 45 * h,
                                          height: 1.38 * h,
                                          letterSpacing: 0.3,
                                          color: AppTheme.blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${info.main.tempMin.toInt()}° / ${info.main.tempMax.toInt()}° | ${info.weather[0].description}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14 * h,
                                    height: 1.5 * h,
                                    letterSpacing: 0.3,
                                    color: AppTheme.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "${Utils.getDateHours(DateTime.now())} Режим УЗТ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14 * h,
                                    height: 1.5 * h,
                                    letterSpacing: 0.3,
                                    color: AppTheme.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          MySeparator(),
                          const Spacer(),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    getWeather(
                                      context,
                                      "assets/images/weather.png",
                                      "Облачность:",
                                      "${info.clouds.all} %",
                                      MainAxisAlignment.start,
                                    ),
                                    getWeather(
                                      context,
                                      "assets/images/shamol.png",
                                      "Ветер:",
                                      "${info.wind.speed} км/ч",
                                      MainAxisAlignment.start,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    getWeather(
                                      context,
                                      "assets/images/namlik.png",
                                      "Влажность:",
                                      "${info.main.humidity} %",
                                      MainAxisAlignment.end,
                                    ),
                                    getWeather(
                                      context,
                                      "assets/images/bosim.png",
                                      "Давление:",
                                      "${info.main.pressure} МБ",
                                      MainAxisAlignment.end,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ServiceShimmer();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
