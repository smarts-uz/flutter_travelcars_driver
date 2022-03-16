import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/main.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/bloc/list_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/calendar_list_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/widgets/calendar_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math' as math;
import '../../../model/api_model/http_result.dart';
import '../../../model/api_model/status_model.dart';
import '../../../utils/center_dialog/center_dialog.dart';
import '../../../utils/utils.dart';
import '../../../widgets/service_widgets/service_shimmer.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  bool change = false;
  bool view1 = false;
  Repository repository = Repository();
  List<bool> close = [];

  @override
  void initState() {
    listBloc.getAllList(_selectedDay);
    get();
    super.initState();
  }

  get() {
    for (int i = 0; i < 100; i++) {
      close.add(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    EdgeInsets.symmetric(horizontal: 8 * w, vertical: 16 * h),
                padding:
                    EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21 * h),
                  color: AppTheme.lightGray,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16 * w, vertical: 32 * h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: AppTheme.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 12 * h,
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectedDay = DateTime(_selectedDay.year,
                                  _selectedDay.month - 1, _selectedDay.day);
                              setState(() {});
                            },
                            child: SizedBox(
                              height: 24 * h,
                              width: 24 * w,
                              child: const Icon(
                                Icons.navigate_before,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "${getMonth(_selectedDay.month)} ${_selectedDay.year} г.",
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 18 * h,
                              height: 21 / 18 * h,
                              letterSpacing: 0.4,
                              color: AppTheme.black,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _selectedDay = _selectedDay.add(
                                const Duration(days: 30),
                              );
                              setState(() {});
                            },
                            child: SizedBox(
                              height: 24 * h,
                              width: 24 * w,
                              child: const Icon(
                                Icons.navigate_next,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8 * h,
                      ),
                      TableCalendar(
                        daysOfWeekVisible: false,
                        headerVisible: false,
                        rowHeight: 32,
                        onPageChanged: (day) {
                          _selectedDay = day;
                          setState(() {});
                        },
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        focusedDay: _selectedDay,
                        onDaySelected: _onDaySelected,
                        firstDay: DateTime(2021, 12, 12),
                        lastDay: DateTime(2099, 12, 21),
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<CalendarListModel>(
                stream: listBloc.listFeedBack,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<String> car = [];
                    List<String> carNumber = [];

                    CalendarListModel list = snapshot.data;
                    for (int i = 0; i < list.data.length; i++) {
                      bool k = false;
                      for (int j = 0; j < car.length; j++) {
                        if (car[j] == list.data[i].car &&
                            carNumber[j] == list.data[i].carNumber) {
                          k = true;
                        }
                      }
                      if (!k) {
                        car.add(list.data[i].car);
                        carNumber.add(list.data[i].carNumber);
                      }
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: car.length,
                      itemBuilder: (context, index) {
                        change = true;
                        for (int i = 0; i < list.data.length; i++) {
                          if (car[index] == list.data[i].car &&
                              carNumber[index] == list.data[i].carNumber) {
                            if (list.data[i].status == 0) {
                              change = false;
                            }
                          }
                        }
                        return Container(
                          height: close[index] ? 500 * h : 160 * h,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 8 * w, vertical: 16 * h),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21 * h),
                            color: AppTheme.lightGray,
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: AppTheme.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 16 * h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        car[index],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontFamily,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16 * h,
                                          height: 18 / 16 * h,
                                          letterSpacing: 0.4,
                                          color: AppTheme.black,
                                        ),
                                      ),
                                    ),
                                    getCarNumber(
                                      context,
                                      Utils.getCarNumber(carNumber[index]),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 12 * h,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        close[index] = !close[index];
                                        setState(() {});
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: close[index]
                                              ? AppTheme.white
                                              : AppTheme.green,
                                          border: Border.all(
                                            width: 1,
                                            color: AppTheme.green,
                                          ),
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                "Маршруты",
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.fontFamily,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12 * h,
                                                  height: 14 / 12 * h,
                                                  letterSpacing: 0.2,
                                                  color: close[index]
                                                      ? AppTheme.green
                                                      : AppTheme.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 2 * w,
                                              ),
                                              Transform.rotate(
                                                angle: close[index]
                                                    ? 90 * math.pi / 180
                                                    : 0,
                                                child: Icon(
                                                  Icons.navigate_next,
                                                  color: close[index]
                                                      ? AppTheme.green
                                                      : AppTheme.white,
                                                  size: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      "Отключить все маршруты:",
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12 * h,
                                        height: 14 / 12 * h,
                                        letterSpacing: 0.2,
                                        color: AppTheme.gray,
                                      ),
                                    ),
                                    CupertinoSwitch(
                                      value: change,
                                      activeColor: AppTheme.green,
                                      trackColor: AppTheme.red,
                                      onChanged: (on) async {
                                        view1 = true;
                                        setState(() {});
                                        for (int i = 0;
                                            i < list.data.length;
                                            i++) {
                                          if (car[index] == list.data[i].car &&
                                              carNumber[index] ==
                                                  list.data[i].carNumber &&
                                              list.data[i].status ==
                                                  (on ? 0 : 1)) {
                                            try {
                                              HttpResult response =
                                                  await repository.changeStatus(
                                                      list.data[i].id);
                                              if (response.isSuccess) {
                                                try {
                                                  StatusModel datam =
                                                      statusModelFromJson(
                                                    json.encode(
                                                        response.result),
                                                  );
                                                  Fluttertoast.showToast(
                                                    msg: datam.message,
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        AppTheme.blue,
                                                    textColor: AppTheme.white,
                                                    fontSize: 16.0,
                                                  );
                                                } catch (e) {
                                                  Fluttertoast.showToast(
                                                    msg: "Статус не изменился",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        AppTheme.blue,
                                                    textColor: AppTheme.white,
                                                    fontSize: 16.0,
                                                  );
                                                }
                                              }
                                            } catch (e) {
                                              CenterDialog.simpleCenterDialog(
                                                context,
                                                "Ошибка",
                                                "У вас есть активный заказ или проверьте подключение к интернету.",
                                              );
                                              break;
                                            }
                                          }
                                        }
                                        listBloc.getAllList(_selectedDay);
                                        view1 = false;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                !close[index]
                                    ? Container()
                                    : Expanded(
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 270),
                                          curve: Curves.easeInOut,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: list.data.length,
                                            itemBuilder: (_, index1) {
                                              if (car[index] ==
                                                      list.data[index1].car &&
                                                  carNumber[index] ==
                                                      list.data[index1]
                                                          .carNumber) {
                                                return TaskWidget(
                                                  data: list.data[index1],
                                                  onChange: (onChange) {
                                                    data[index1].check =
                                                        onChange;
                                                    setState(() {});
                                                  },
                                                  date: _selectedDay,
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const TaskShimmer();
                  }
                },
              ),
              SizedBox(
                height: 28 * h,
              ),
            ],
          ),
          if (!view1)
            Container()
          else
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppTheme.black.withOpacity(0.3),
                ),
                child: const CircularProgressIndicator(
                  color: AppTheme.green,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(
      () {
        if (DateTime.now().isBefore(selectedDay)) {
          listBloc.getAllList(selectedDay);
          _selectedDay = selectedDay;
        }
      },
    );
  }
}
