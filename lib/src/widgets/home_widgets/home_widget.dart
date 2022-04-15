import 'package:flutter/cupertino.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';

import '../../utils/utils.dart';

Widget getHomeTasks(BuildContext context, String date, String title) {
  // double h = Utils.height(context);
  // double w = Utils.width(context);
  return Container(
    width: 200,
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
    margin: const EdgeInsets.symmetric(horizontal: 12),
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
          style: const TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 16,
            height: 1.4,
            letterSpacing: 0.4,
            color: AppTheme.gray,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          color: AppTheme.greyE8,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
          style: const TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 18,
            height: 1.38,
            letterSpacing: 0.2,
            color: AppTheme.black36,
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
                fontSize: 18 * h,
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
