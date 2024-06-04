import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/center_dialog/center_dialog.dart';
import '../../utils/utils.dart';
import '../../widgets/add_number_pin.dart';

class PinCodeScreen extends StatefulWidget {
  final int status;

  const PinCodeScreen({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  _PinCodeScreenState createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  int one = 11;
  int two = 11;
  int three = 11;
  int four = 11;
  String code = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.blue,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 60 * h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12 * h),
                bottomRight: Radius.circular(12 * h),
              ),
              color: AppTheme.blue,
            ),
            child: Center(
              child: Text(
                "Pin Code",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22 * h,
                  height: 26 / 22 * h,
                  color: AppTheme.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100 * h,
          ),
          Row(
            children: [
              SizedBox(
                width: 16 * w,
              ),
              Expanded(
                child: Container(
                  height: 90 * h,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border.all(
                      width: 2 * h,
                      color: AppTheme.lightGray,
                    ),
                    borderRadius: BorderRadius.circular(15 * h),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 270),
                        height: one < 11 ? 15 * h : 0,
                        width: one < 11 ? 15 * h : 0,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2 * h,
                            color: AppTheme.lightGray,
                          ),
                          borderRadius: BorderRadius.circular(15 * h),
                          color: one < 11 ? AppTheme.blue : AppTheme.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 12 * w,
              ),
              Expanded(
                child: Container(
                  height: 90 * h,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border.all(
                      width: 2 * h,
                      color: AppTheme.lightGray,
                    ),
                    borderRadius: BorderRadius.circular(15 * h),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 270),
                        height: two < 11 ? 15 * h : 0,
                        width: two < 11 ? 15 * h : 0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15 * h),
                          color: two < 11 ? AppTheme.blue : AppTheme.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 12 * w,
              ),
              Expanded(
                child: Container(
                  height: 90 * h,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border.all(
                      width: 2 * h,
                      color: AppTheme.lightGray,
                    ),
                    borderRadius: BorderRadius.circular(15 * h),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 270),
                        height: three < 11 ? 15 * h : 0,
                        width: three < 11 ? 15 * h : 0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15 * h),
                          color: three < 11 ? AppTheme.blue : AppTheme.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 12 * w,
              ),
              Expanded(
                child: Container(
                  height: 90 * h,
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    border: Border.all(
                      width: 2 * h,
                      color: AppTheme.lightGray,
                    ),
                    borderRadius: BorderRadius.circular(15 * h),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 270),
                        height: four < 11 ? 15 * h : 0,
                        width: four < 11 ? 15 * h : 0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15 * h),
                          color: four < 11 ? AppTheme.blue : AppTheme.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 16 * w,
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                width: 16 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "1",
                  onTap: () {
                    _addNumber(1);
                  },
                ),
              ),
              SizedBox(
                width: 14 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "2",
                  onTap: () {
                    _addNumber(2);
                  },
                ),
              ),
              SizedBox(
                width: 14 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "3",
                  onTap: () {
                    _addNumber(3);
                  },
                ),
              ),
              SizedBox(
                width: 16 * w,
              ),
            ],
          ),
          SizedBox(
            height: 16 * h,
          ),
          Row(
            children: [
              SizedBox(
                width: 16 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "4",
                  onTap: () {
                    _addNumber(4);
                  },
                ),
              ),
              SizedBox(
                width: 14 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "5",
                  onTap: () {
                    _addNumber(5);
                  },
                ),
              ),
              SizedBox(
                width: 14 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "6",
                  onTap: () {
                    _addNumber(6);
                  },
                ),
              ),
              SizedBox(
                width: 16 * w,
              ),
            ],
          ),
          SizedBox(
            height: 14 * h,
          ),
          Row(
            children: [
              SizedBox(
                width: 16 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "7",
                  onTap: () {
                    _addNumber(7);
                  },
                ),
              ),
              SizedBox(
                width: 14 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "8",
                  onTap: () {
                    _addNumber(8);
                  },
                ),
              ),
              SizedBox(
                width: 14 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "9",
                  onTap: () {
                    _addNumber(9);
                  },
                ),
              ),
              SizedBox(
                width: 16 * w,
              ),
            ],
          ),
          SizedBox(
            height: 14 * h,
          ),
          Row(
            children: [
              SizedBox(
                width: 16 * w,
              ),
              const Spacer(),
              SizedBox(
                width: 14 * w,
              ),
              Expanded(
                child: AddNumber(
                  number: "0",
                  onTap: () {
                    _addNumber(0);
                  },
                ),
              ),
              SizedBox(
                width: 14 * w,
              ),
              Expanded(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16 * h),
                  onTap: () {
                    _removeNumber();
                  },
                  child: Container(
                    height: 64 * h,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      border: Border.all(
                        width: 2 * h,
                        color: AppTheme.lightGray,
                      ),
                      borderRadius: BorderRadius.circular(15 * h),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/exclude.png',
                          height: 20 * h,
                          width: 28 * w,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16 * w,
              ),
            ],
          ),
          SizedBox(
            height: (Platform.isIOS ? 126 : 112) * h,
          )
        ],
      ),
    );
  }

  void _removeNumber() {
    int a = 11;
    setState(() {
      if (four < 10) {
        four = a;
      } else if (three < 10) {
        three = a;
      } else if (two < 10) {
        two = a;
      } else if (one < 10) {
        one = a;
      }
    });
  }

  void _addNumber(int a) {
    setState(
          () {
        if (one > 10) {
          one = a;
        } else if (two > 10) {
          two = a;
        } else if (three > 10) {
          three = a;
        } else if (four > 10) {
          four = a;
          _getCode();
        }
      },
    );
  }

  _getCode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String pin = pref.getString("pin") ?? "";
    code = one.toString() + two.toString() + three.toString() + four.toString();
    if (pin == code) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    } else {
      setState(() {
        four = 11;
        three = 11;
        two = 11;
        one = 11;
      });
      CenterDialog.simpleCenterDialog(
        context,
        "Ошибка",
        "Пожалуйста, попробуйте еще раз с ошибкой пароля",
      );
    }
  }
}
