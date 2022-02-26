import 'package:flutter/cupertino.dart';
import 'package:flutter_travelcars_driver/src/model/task_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/widgets/utils_widgets.dart';

import '../utils/utils.dart';

Widget taskWidget(TaskModel data, Function(bool check) onchange) {
  return Column(
    children: [
      SizedBox(
        height: 10,
      ),
      MySeparator(),
      const SizedBox(
        height: 10,
      ),
      Row(
        children: [
          RichText(
            text: TextSpan(
                text: "",
                style: const TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  height: 1.38,
                  color: AppTheme.black,
                ),
                children: <TextSpan>[
                  TextSpan(text: data.place1),
                  const TextSpan(text: "-"),
                  TextSpan(text: data.place2),
                ]),
          ),
        ],
      ),
      const SizedBox(
        height: 4,
      ),
      Row(
        children: [
          Text(
            data.status,
            style: TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              fontSize: 12,
              height: 14 / 12,
              letterSpacing: 0.2,
              color: data.check ? AppTheme.green : AppTheme.red,
            ),
          ),
          const Spacer(),
          Text(
            data.check ? "Свободен:" : "Занят:",
            style: const TextStyle(
              fontFamily: AppTheme.fontFamily,
              fontWeight: FontWeight.normal,
              fontStyle: FontStyle.normal,
              fontSize: 12,
              height: 14 / 12,
              letterSpacing: 0.2,
              color: AppTheme.gray,
            ),
          ),
          CupertinoSwitch(
            value: data.check,
            activeColor: AppTheme.green,
            trackColor: AppTheme.red,
            onChanged: (on) async {
              onchange(!data.check);
            },
          ),
        ],
      )
    ],
  );
}

Widget getCarNumber(BuildContext context, String number) {
  double h = Utils.height(context);
  double w = Utils.width(context);
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      color: AppTheme.blue,
    ),
    child: Center(
      child: Text(
        number,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 12 * h,
          height: 14 / 12 * h,
          letterSpacing: 0.2,
          color: AppTheme.white,
        ),
      ),
    ),
  );
}
