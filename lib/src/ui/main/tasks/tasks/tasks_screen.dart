import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/model/task_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/tasks/task_view_screen.dart';
import 'package:flutter_travelcars_driver/src/widgets/calendar_widget.dart';

import '../../../../utils/utils.dart';

class TasksScreen extends StatefulWidget {
  final List<TaskModel> data;

  const TasksScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskViewScreen(
                    data: widget.data[index],
                  ),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
              padding: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21 * h),
                color: AppTheme.lightGray,
              ),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 20 * w, vertical: 10 * h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: AppTheme.white,
                ),
                child: Row(
                  children: [
                    Text(
                      "413",
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 18 * h,
                        height: 1.5,
                        color: AppTheme.black,
                      ),
                    ),
                    Container(
                      height: 83,
                      width: 1,
                      margin: EdgeInsets.symmetric(horizontal: 16 * w),
                      color: const Color.fromRGBO(235, 235, 235, 0.42),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ташкент - Экскурсия по городу",
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.normal,
                            fontSize: 14 * h,
                            height: 1.5,
                            color: AppTheme.black,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Chevrolet Captiva",
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamily,
                                fontWeight: FontWeight.normal,
                                fontSize: 14 * h,
                                height: 1.4,
                                color: AppTheme.gray,
                              ),
                            ),
                            SizedBox(
                              width: 8 * w,
                            ),
                            getCarNumber(
                              context,
                              "01A777AA",
                            ),
                          ],
                        ),
                        Text(
                          "AZIZBEK",
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.normal,
                            fontSize: 14 * h,
                            height: 1.5,
                            color: AppTheme.black,
                          ),
                        ),
                        Text(
                          "Отправление: 24.02.2022",
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.normal,
                            fontSize: 14 * h,
                            height: 1.5,
                            color: AppTheme.gray,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
