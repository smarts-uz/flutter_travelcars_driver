import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/data_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/task_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/data_shimmer.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/home_widget.dart';
import '../../../bloc/data_bloc.dart';
import '../../../bloc/task_bloc.dart';

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
  void initState() {
    dataBloc.getAllData();
    taskBloc.getTasksAll();
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
          StreamBuilder(
            stream: dataBloc.dataFeedback,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data!.data != null) {
                DataModel info = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: 20 * w, right: 20 * w, top: 20 * w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10 * w, vertical: 10 * h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21 * h),
                        color: AppTheme.lightGray,
                      ),
                      child: info.data.isEmpty
                          ? Column(
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
                                        TextSpan(text: "Пустой"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 230,
                              child: PageView.builder(
                                itemCount: info.data.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16 * w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                fontSize: 20 * h,
                                                height: 1.4 * h,
                                                letterSpacing: 0.4,
                                                color: AppTheme.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:
                                                      "${info.data[index].car} - ${info.data[index].carNumber}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 158 * h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.only(top: 16 * h),
                                          padding: EdgeInsets.all(12 * h),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(21),
                                            color: AppTheme.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0, 0),
                                                blurRadius: 10,
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.1),
                                              )
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                info.data[index].date,
                                                style: TextStyle(
                                                  fontFamily:
                                                      AppTheme.fontFamily,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 18 * h,
                                                  color: AppTheme.gray,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12 * h,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${info.data[index].cityFrom} - ${info.data[index].cityTo}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontFamily,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 22 * h,
                                                    color: AppTheme.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                          horizontal: 20 * w, vertical: 20 * h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 12 * w, vertical: 10 * h),
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
                              fontSize: 22 * h,
                              height: 1.4 * h,
                              letterSpacing: 0.2,
                              color: AppTheme.black,
                            ),
                          ),
                          SizedBox(
                            height: 10 * h,
                          ),
                          Container(
                            height: 160,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: info.data.isEmpty
                                ? const Center(
                                    child: Text("Пустой"),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: info.data.length,
                                    itemBuilder: (_, index) {
                                      return getHomeTasks(
                                        context,
                                        info.data[index].date,
                                        "${info.data[index].cityFrom} ${info.data[index].cityTo}",
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const DataShimmer();
              }
            },
          ),
          SizedBox(
            height: 20 * h,
          ),
          StreamBuilder(
            stream: taskBloc.taskFeedback,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                TaskModel tasks = snapshot.data!;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.symmetric(horizontal: 20 * w, vertical: 0 * h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10 * w, vertical: 6 * h),
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
                          fontSize: 20 * h,
                          height: 1.4 * h,
                          letterSpacing: 0.4,
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(
                        height: 16 * h,
                      ),
                      getContainer(context, "Всего заявок обработано: ",
                          tasks.data.done, AppTheme.blue, (on) {
                        widget.onChange(0);
                      }),
                      getContainer(context, "Активные текущие заявки: ",
                          tasks.data.active, AppTheme.green, (onChange) {
                        widget.onChange(1);
                      }),
                      getContainer(context, "На рассмотрении: ",
                          tasks.data.proceed, AppTheme.yellow, (onChange) {
                        widget.onChange(2);
                      }),
                    ],
                  ),
                );
              } else {
                return const DataShimmer();
              }
            },
          ),
        ],
      ),
    );
  }
}
