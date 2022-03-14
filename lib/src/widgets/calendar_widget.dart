import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/bloc/list_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/calendar_list_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/status_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/center_dialog/center_dialog.dart';
import 'package:flutter_travelcars_driver/src/widgets/utils_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/utils.dart';

class TaskWidget extends StatelessWidget {
  final Datum data;
  final Function(bool check) onChange;
  final DateTime date;

  TaskWidget({
    Key? key,
    required this.data,
    required this.onChange,
    required this.date,
  }) : super(key: key);
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        const MySeparator(),
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
                    TextSpan(text: data.cityFrom),
                    const TextSpan(text: " - "),
                    TextSpan(text: data.cityTo),
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
              "Status",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                fontSize: 12,
                height: 14 / 12,
                letterSpacing: 0.2,
                color: data.status == 1 ? AppTheme.green : AppTheme.red,
              ),
            ),
            const Spacer(),
            Text(
              data.status == 1 ? "Свободен:" : "Занят:",
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
              value: data.status == 1,
              activeColor: AppTheme.green,
              trackColor: AppTheme.red,
              onChanged: (on) async {
                try {
                  HttpResult response = await repository.changeStatus(data.id);
                  if (response.isSuccess) {
                    StatusModel datam = statusModelFromJson(
                      json.encode(response.result),
                    );
                    Fluttertoast.showToast(
                      msg: datam.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: AppTheme.blue,
                      textColor: AppTheme.white,
                      fontSize: 16.0,
                    );
                  }
                  listBloc.getAllList(date);
                } catch (e) {
                  CenterDialog.simpleCenterDialog(
                    context,
                    "Message",
                    e.toString(),
                  );
                }
              },
            ),
          ],
        )
      ],
    );
  }
}

Widget getCarNumber(BuildContext context, String number) {
  double h = Utils.height(context);
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
