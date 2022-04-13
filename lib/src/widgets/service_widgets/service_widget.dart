import 'package:flutter/cupertino.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';

import '../../theme/app_theme.dart';

Widget getWeather(BuildContext context, String img, String title, String body,
    MainAxisAlignment axis) {
  double h = Utils.height(context);
  double w = Utils.width(context);
  return Row(
    mainAxisAlignment: axis,
    children: [
      Container(
        height: 40 * h,
        width: 40 * w,
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          img,
        ),
      ),
      Text(
        title,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 10 * h,
          height: 1.5 * h,
          letterSpacing: 0.3,
          color: AppTheme.black,
        ),
      ),
      Text(
        " $body",
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          fontSize: 10 * h,
          height: 1.5 * h,
          letterSpacing: 0.3,
          color: AppTheme.black,
        ),
      ),
    ],
  );
}
