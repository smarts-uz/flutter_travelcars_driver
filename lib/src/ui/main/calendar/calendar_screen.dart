import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/bloc/list_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/calendar_view_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/widgets/calendar_widget.dart';
import 'package:flutter_travelcars_driver/src/widgets/item_calendar.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
              ItemCalendar(
                h: h,
                w: w,
                selectedDay: _selectedDay,
                onSelectedDay: (date1, date2) {
                  _onDaySelected(date1, date2);
                },
                change: (change) {
                  setState(() {
                    _selectedDay = change;
                  });
                },
              ),
              StreamBuilder<List<CalendarViewModel>>(
                stream: listBloc.listFeedBack,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<CalendarViewModel> list = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        change = false;
                        for (int i = 0; i < list[index].data.length; i++) {
                          if (list[index].car == list[index].data[i].car &&
                              list[index].carNumber ==
                                  list[index].data[i].carNumber) {
                            if (list[index].data[i].status == 1) {
                              change = true;
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
                                        list[index].car,
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
                                      Utils.getCarNumber(list[index].carNumber),
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
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: list[index].bookingId == 1
                                              ? Colors.red
                                              : close[index]
                                                  ? AppTheme.white
                                                  : AppTheme.green,
                                          border: Border.all(
                                            width: 1,
                                            color: list[index].bookingId == 1
                                                ? Colors.red
                                                : AppTheme.green,
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
                                                  fontSize: 10 * h,
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
                                        fontSize: 11 * h,
                                        height: 14 / 12 * h,
                                        letterSpacing: 0.2,
                                        color: AppTheme.gray,
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 0.7,
                                      child: CupertinoSwitch(
                                        value: list[index].bookingId == 1
                                            ? false
                                            : change,
                                        activeColor: AppTheme.green,
                                        trackColor: list[index].bookingId == 1
                                            ? Colors.red
                                            : AppTheme.red,
                                        onChanged: (on) async {
                                          if (list[index].bookingId != 1) {
                                            view1 = true;
                                            setState(() {});
                                            for (int i = 0;
                                                i < list[index].data.length;
                                                i++) {
                                              if (list[index].data[i].status ==
                                                  (on ? 0 : 1)) {
                                                try {
                                                  HttpResult response =
                                                      await repository
                                                          .changeStatus(
                                                              list[index]
                                                                  .data[i]
                                                                  .id);
                                                  if (response.isSuccess) {
                                                    try {
                                                      // ignore: unused_local_variable
                                                      StatusModel datam =
                                                          statusModelFromJson(
                                                        json.encode(
                                                            response.result),
                                                      );
                                                    } catch (e) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Статус не изменился",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            AppTheme.blue,
                                                        textColor:
                                                            AppTheme.white,
                                                        fontSize: 16.0,
                                                      );
                                                    }
                                                  }
                                                } catch (e) {
                                                  CenterDialog
                                                      .simpleCenterDialog(
                                                    context,
                                                    "Ошибка",
                                                    "У вас есть активный заказ или проверьте подключение к интернету.",
                                                  );
                                                  break;
                                                }
                                              }
                                            }
                                            Fluttertoast.showToast(
                                              msg: "Статус изменился",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: AppTheme.blue,
                                              textColor: AppTheme.white,
                                              fontSize: 16.0,
                                            );
                                            listBloc.getAllList(_selectedDay);
                                            view1 = false;
                                            setState(() {});
                                          }
                                        },
                                      ),
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
                                            itemCount: list[index].data.length,
                                            itemBuilder: (_, index1) {
                                              return TaskWidget(
                                                data: list[index].data[index1],
                                                onChange: (onChange) {},
                                                date: _selectedDay,
                                                type: list[index].bookingId,
                                              );
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
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: AppTheme.black.withOpacity(0.5),
                ),
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
        ],
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(
      () {
        if ((DateTime.now().day <= selectedDay.day &&
                DateTime.now().month == selectedDay.month) ||
            DateTime.now().month < selectedDay.month) {
          listBloc.getAllList(selectedDay);
          _selectedDay = selectedDay;
        }
      },
    );
  }
}
