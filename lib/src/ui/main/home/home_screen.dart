import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/bloc/history_bloc.dart';
import 'package:flutter_travelcars_driver/src/bloc/task_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/history_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/task_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/data_shimmer.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/home_widget.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/tab_view_booking.dart';

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
  int size = 0;

  @override
  void initState() {
    historyBloc.getAllHistory("active", 1);
    taskBloc.getTasksAll();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    historyBloc.dispose();
    taskBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: ListView(
        children: [
          StreamBuilder(
            stream: historyBloc.historyFeedback,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data!.data != null) {
                HistoryModel info = snapshot.data!;
                return TabViewBooking(
                  h: h,
                  w: w,
                  size: size,
                  info: info,
                  onChange: (d) {
                    setState(() {
                      size = d;
                    });
                  },
                );
              } else {
                return const DataShimmer();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: taskBloc.taskFeedback,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                TaskModel tasks = snapshot.data!;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: AppTheme.lightGray,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Основные разделы",
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          height: 1.4,
                          letterSpacing: 0.4,
                          color: AppTheme.black,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      getContainer(
                        context,
                        "Всего заявок обработано: ",
                        tasks.data.done,
                        AppTheme.blue,
                        (on) {
                          widget.onChange(0);
                        },
                      ),
                      getContainer(
                        context,
                        "Активные текущие заявки: ",
                        tasks.data.active,
                        AppTheme.green,
                        (onChange) {
                          widget.onChange(1);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const DataShimmer();
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
