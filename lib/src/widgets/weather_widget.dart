import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/weather_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/service_widgets/service_widget.dart';
import 'package:flutter_travelcars_driver/src/widgets/utils_widgets.dart';

class WeatherWidget extends StatelessWidget {
  final double h;
  final double w;
  final WeatherModel info;

  const WeatherWidget({
    Key? key,
    required this.h,
    required this.w,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      fontSize: 12 * h,
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
                      fontSize: 12 * h,
                      height: 1.5 * h,
                      letterSpacing: 0.3,
                      color: AppTheme.black,
                    ),
                  ),
                ),
              ],
            ),
            const MySeparator(),
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
  }
}
