import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widget.dart';

import '../../../../main.dart';

class HomeScreen extends StatefulWidget {
  final Function(int id) onChange;

  const HomeScreen({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 20 * w, right: 20 * w, top: 20 * w),
            padding: EdgeInsets.symmetric(horizontal: 10 * w, vertical: 10 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.lightGray,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10 * h),
                  child: RichText(
                    text: TextSpan(
                      text: "",
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 16 * h,
                        height: 1.4 * h,
                        letterSpacing: 0.4,
                        color: AppTheme.black,
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: "Chevrolet Captiva - 01R200GA"),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 158 * h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 16 * h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                      )
                    ],
                  ),
                  child: Image.asset(
                    "assets/images/image.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150 * h,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20 * w, vertical: 20 * h),
            padding: EdgeInsets.symmetric(horizontal: 12 * w, vertical: 10 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.lightGray,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Активные заявки",
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 18 * h,
                    height: 1.4 * h,
                    letterSpacing: 0.4,
                    color: AppTheme.black,
                  ),
                ),
                SizedBox(
                  height: 10 * h,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return getHomeTasks(
                        context,
                        "24.02.2022",
                        "Ташкент Экскурсия по городу",
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20 * h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20 * w, vertical: 0 * h),
            padding: EdgeInsets.symmetric(horizontal: 10 * w, vertical: 6 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.lightGray,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Основные разделы",
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamily,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 18 * h,
                    height: 1.4 * h,
                    letterSpacing: 0.4,
                    color: AppTheme.black,
                  ),
                ),
                SizedBox(
                  height: 16 * h,
                ),
                getContainer(
                    context, "Всего заявок обработано: ", 4, AppTheme.blue,
                    (on) {
                  widget.onChange(0);
                }),
                getContainer(
                    context, "Активные текущие заявки: ", 1, AppTheme.green,
                    (onChange) {
                  widget.onChange(1);
                }),
                getContainer(context, "На рассмотрении: ", 0, AppTheme.yellow,
                    (onChange) {
                  widget.onChange(2);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
