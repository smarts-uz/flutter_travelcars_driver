import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_widget.dart';

import '../../../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _pass1Controller = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();
  final TextEditingController _pass3Controller = TextEditingController();
  final TextEditingController _pin1Controller = TextEditingController();
  final TextEditingController _pin2Controller = TextEditingController();
  bool value = false;

  @override
  void initState() {
    super.initState();
    _nameController.text = "Azizbek";
    _costController.text = "0";
    _statusController.text = "Не оплачено";
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: ListView(
        children: [
          Container(
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
              padding:
                  EdgeInsets.symmetric(horizontal: 24 * w, vertical: 20 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: AppTheme.white,
              ),
              child: Column(
                children: [
                  getTextController(
                    context,
                    _nameController,
                    "Имя",
                  ),
                  getTextController(
                    context,
                    _costController,
                    "Стоимость поездки",
                  ),
                  getTextController(
                    context,
                    _statusController,
                    "Статус оплаты",
                  ),
                ],
              ),
            ),
          ),
          Container(
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
              padding:
                  EdgeInsets.symmetric(horizontal: 24 * w, vertical: 20 * h),
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
                    _pass1Controller,
                    "Текущий пароль",
                  ),
                  getTextEditController(
                    context,
                    _pass2Controller,
                    "Новый пароль",
                  ),
                  getTextEditController(
                    context,
                    _pass3Controller,
                    "Подтвердите пароль",
                  ),
                  Row(
                    children: [
                      CupertinoSwitch(
                        value: value,
                        activeColor: AppTheme.blue,
                        trackColor: AppTheme.red,
                        onChanged: (on) {
                          value = !value;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        width: 10 * w,
                      ),
                      Text(
                        "Pod Server / Test Server",
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          fontSize: 16 * h,
                          height: 1.38 * h,
                          color: const Color.fromRGBO(54, 69, 90, 0.73),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22 * h,
                  ),
                  getButtonProfile(context, "Изменить", (on) {}),
                ],
              ),
            ),
          ),
          Container(
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
              padding:
                  EdgeInsets.symmetric(horizontal: 24 * w, vertical: 20 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: AppTheme.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Пин",
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
                    _pin1Controller,
                    "Новый пин",
                  ),
                  getTextEditController(
                    context,
                    _pin2Controller,
                    "Подтвердите пин",
                  ),
                  getButtonProfile(context, "Установить", (on) {}),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40 * h,
          ),
        ],
      ),
    );
  }
}
