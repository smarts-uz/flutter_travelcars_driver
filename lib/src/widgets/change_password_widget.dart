import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/profile_edit_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/center_dialog/center_dialog.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_widget.dart';

class ChangePasswordWidget extends StatelessWidget {
  final double h;
  final double w;
  final TextEditingController pass1Controller;
  final TextEditingController pass2Controller;
  final TextEditingController pass3Controller;
  final Repository repository;
  final bool circle;
  final Function(bool check) onChange;

  const ChangePasswordWidget({
    Key? key,
    required this.h,
    required this.w,
    required this.pass1Controller,
    required this.pass2Controller,
    required this.pass3Controller,
    required this.repository,
    required this.circle,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        left: 8 * w,
        right: 8 * w,
        top: 16,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21 * h),
        color: AppTheme.lightGray,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24 * w, vertical: 20 * h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: AppTheme.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Пароль",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 18 * h,
                height: 1.38 * h,
                color: AppTheme.black,
              ),
            ),
            getTextEditController(
              context,
              pass1Controller,
              "Текущий пароль",
            ),
            getTextEditController(
              context,
              pass2Controller,
              "Новый пароль",
            ),
            getTextEditController(
              context,
              pass3Controller,
              "Подтвердите пароль",
            ),
            SizedBox(
              height: 22 * h,
            ),
            GestureDetector(
              onTap: () async {
                onChange(true);
                HttpResult response = await repository.setProfileEdit(
                  pass1Controller.text,
                  pass2Controller.text,
                  pass3Controller.text,
                );
                ProfileEditModel data = profileEditModelFromJson(
                  json.encode(response.result),
                );
                onChange(false);
                CenterDialog.simpleCenterDialog(
                  context,
                  "Сообщение",
                  data.resultMessage,
                );
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10 * h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppTheme.blue,
                ),
                child: !circle
                    ? Center(
                        child: Text(
                          "Изменить".toUpperCase(),
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontSize: 16 * h,
                            height: 24 / 16 * h,
                            color: AppTheme.white,
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
