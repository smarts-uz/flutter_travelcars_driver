import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/bloc/data_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/profile_edit_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/profile_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/center_dialog/center_dialog.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/utils.dart';
import '../../../widgets/service_widgets/service_shimmer.dart';

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
  final TextEditingController _pin0Controller = TextEditingController();
  final TextEditingController _pin1Controller = TextEditingController();
  final TextEditingController _pin2Controller = TextEditingController();
  Repository repository = Repository();
  bool value = false;
  bool circle = false;
  bool one = false;

  @override
  void initState() {
    super.initState();
    get();
    dataBloc.getProfileData();
  }

  get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    one = prefs.getString("pin") == null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: ListView(
        children: [
          SizedBox(
            height: 280 * h,
            child: StreamBuilder(
              stream: dataBloc.profileFeedback,
              builder: (context, AsyncSnapshot<ProfileModel> snapshot) {
                if (snapshot.hasData) {
                  ProfileModel data = snapshot.data!;
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      left: 8 * w,
                      right: 8 * w,
                      top: 16,
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 8 * w, vertical: 8 * h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21 * h),
                      color: AppTheme.lightGray,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24 * w, vertical: 20 * h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: AppTheme.white,
                      ),
                      child: Column(
                        children: [
                          getTextController(
                            context,
                            data.data.name,
                            "Имя",
                          ),
                          getTextController(
                            context,
                            data.data.username,
                            "Логин",
                          ),
                          getTextController(
                            context,
                            data.data.phone,
                            "Телефон",
                          ),
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
                  GestureDetector(
                    onTap: () async {
                      circle = true;
                      setState(() {});
                      HttpResult response = await repository.setProfileEdit(
                        _pass1Controller.text,
                        _pass2Controller.text,
                        _pass3Controller.text,
                      );
                      ProfileEditModel data = profileEditModelFromJson(
                        json.encode(response.result),
                      );
                      circle = false;
                      setState(() {});
                      CenterDialog.simpleCenterDialog(
                        context,
                        "Message",
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
                  !one
                      ? getTextEditController(
                          context,
                          _pin0Controller,
                          "Текущий пин",
                        )
                      : Container(),
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
                  getButtonProfile(context, "Установить", (on) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    bool k = false;
                    String s = "";
                    String pin = prefs.getString("pin") ?? "";
                    if (!one) {
                      print(pin);
                      if (_pin0Controller.text == pin) {
                        k = false;
                      } else {
                        k = true;
                      }
                    }
                    if (_pin1Controller.text == _pin2Controller.text && !k) {
                      prefs.setString("pin", _pin1Controller.text);
                      s = "Uspeshno";
                    } else {
                      s = "Net udayetsa";
                    }
                    FocusScope.of(context).requestFocus(FocusNode());
                    CenterDialog.simpleCenterDialog(
                      context,
                      "Message",
                      s,
                    );
                  }),
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
