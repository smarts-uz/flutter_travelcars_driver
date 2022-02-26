import 'package:flutter/cupertino.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';

import '../utils/utils.dart';

Widget getHomeTasks(BuildContext context, String date, String title) {
  double h = Utils.height(context);
  double w = Utils.width(context);
  return Container(
    width: 162 * w,
    padding: EdgeInsets.symmetric(horizontal: 2 * w, vertical: 10 * h),
    margin: EdgeInsets.symmetric(horizontal: 12 * w),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(21),
      color: AppTheme.white,
      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 0),
          blurRadius: 10,
          color: Color.fromRGBO(0, 0, 0, 0.1),
        )
      ],
    ),
    child: Column(
      children: [
        Text(
          date,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 16 * h,
            height: 1.4 * h,
            letterSpacing: 0.4,
            color: AppTheme.gray,
          ),
        ),
        SizedBox(
          height: 4 * h,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 14 * h,
            height: 1.38 * h,
            letterSpacing: 0.2,
            color: AppTheme.lightBlack,
          ),
        ),
      ],
    ),
  );
}

Widget getContainer(BuildContext context, String text, int count, Color color,
    Function(int index) onChange) {
  double h = Utils.height(context);
  double w = Utils.width(context);
  return GestureDetector(
    onTap: () {
      onChange(0);
    },
    child: Container(
      height: 33 * h,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 10 * h),
      padding: EdgeInsets.symmetric(horizontal: 10 * w, vertical: 4 * h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 10,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          )
        ],
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: "",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontSize: 14 * h,
                height: 1.38 * h,
                letterSpacing: 0.2,
                color: AppTheme.white,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: text,
                ),
                TextSpan(
                  text: count.toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
