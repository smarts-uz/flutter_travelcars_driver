import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/main.dart';
import 'package:flutter_travelcars_driver/src/bloc/list_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/calendar_list_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/widgets/calendar_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math' as math;
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
  bool view = false;

  @override
  void initState() {
    listBloc.getAllList(_selectedDay);
    super.initState();
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
            margin: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 16 * h),
            padding: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.lightGray,
            ),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16 * w, vertical: 32 * h),
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
                      Expanded(
                        child: Text(
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
                      ),
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
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
                CalendarListModel list = snapshot.data;
                return Container(
                  height: view ? 422 * h : 160 * h,
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.symmetric(horizontal: 8 * w, vertical: 16 * h),
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
                        Text(
                          "Маршруты",
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
                        SizedBox(
                          height: 16 * h,
                        ),
                        Row(
                          children: [
                            Text(
                              list.data[0].car,
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                                fontSize: 16 * h,
                                height: 18 / 16 * h,
                                letterSpacing: 0.2,
                                color: AppTheme.gray,
                              ),
                            ),
                            SizedBox(
                              width: 12 * w,
                            ),
                            getCarNumber(
                              context,
                              list.data[0].carNumber,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8 * h,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                view = !view;
                                setState(() {});
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color:
                                        view ? AppTheme.white : AppTheme.green,
                                    border: Border.all(
                                      width: 1,
                                      color: AppTheme.green,
                                    )),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Маршруты",
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontFamily,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12 * h,
                                          height: 14 / 12 * h,
                                          letterSpacing: 0.2,
                                          color: view
                                              ? AppTheme.green
                                              : AppTheme.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2 * w,
                                      ),
                                      Transform.rotate(
                                        angle: view ? 90 * math.pi / 180 : 0,
                                        child: Icon(
                                          Icons.navigate_next,
                                          color: view
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
                                setState(
                                  () {
                                    change = !change;
                                    for (int i = 0; i < data.length; i++) {
                                      data[i].check = change;
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        !view
                            ? Container()
                            : Expanded(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 270),
                                  curve: Curves.easeInOut,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: list.data.length,
                                    itemBuilder: (_, index) {
                                      return taskWidget(
                                        list.data[index],
                                        _selectedDay,
                                        (onchange) {
                                          data[index].check = onchange;
                                          setState(() {});
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
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
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    listBloc.getAllList(selectedDay);
    setState(() {
      _selectedDay = selectedDay;
    });
  }
}
