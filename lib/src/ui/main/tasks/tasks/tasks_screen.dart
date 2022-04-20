import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/data_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/history_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/tasks/task_view_screen.dart';
import 'package:flutter_travelcars_driver/src/widgets/calendar_widget.dart';

import '../../../../model/api_model/http_result.dart';
import '../../../../utils/utils.dart';
import '../../../../widgets/service_widgets/service_shimmer.dart';

class TasksScreen extends StatefulWidget {
  final String type;

  const TasksScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  var scrollController = ScrollController();
  Repository repository = Repository();
  int page = 1;
  int last = 1;
  bool circle = false;
  List<Datum> data = <Datum>[];

  @override
  void initState() {
    get(1);
    scrollController.addListener(pagination);
    super.initState();
  }

  get(int page) async {
    try {
      if (page == 1) {
        circle = true;
        setState(() {});
      }
      HttpResult response = await repository.getHistory(widget.type, page);

      if (response.isSuccess) {
        HistoryModel repos = historyModelFromJson(
          json.encode(response.result),
        );
        last = repos.meta.lastPage;
        for (int i = 0; i < repos.data.length; i++) {
          data.add(repos.data[i]);
        }
        circle = false;
        setState(() {});
      }
    } catch (_) {}
  }

  Future<void> pagination() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (last >= page + 1) {
        page += 1;
        get(page);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: circle
          ? const TaskShimmer()
          : ListView.builder(
              itemCount: data.length,
              controller: scrollController,
              addAutomaticKeepAlives: false,
              itemBuilder: (_, index) {
                return data.isEmpty
                    ? const Center(
                        child: Text("Пустой"),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskViewScreen(
                                data: data[index],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(
                              horizontal: 8 * w, vertical: 8 * h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 8 * w, vertical: 8 * h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(21 * h),
                            color: AppTheme.lightGray,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20 * w, vertical: 10 * h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(21),
                              color: AppTheme.white,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  data[index].id.toString(),
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
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 12 * w),
                                  color:
                                      const Color.fromRGBO(235, 235, 235, 0.42),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          child: Text(
                                            data[index].car,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontFamily,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12 * h,
                                              height: 1.4,
                                              color: AppTheme.gray,
                                            ),
                                          ),
                                        ),
                                        getCarNumber(
                                          context,
                                          Utils.getCarNumber(
                                            data[index].carNumber,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 220 * h,
                                      child: Text(
                                        "${data[index].cityFrom} - ${data[index].cityTo} ${data[index].reverse == 1 ? "- \n ${data[index].cityFrom}" : ""}",
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontFamily,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14 * h,
                                          height: 1.5,
                                          color: AppTheme.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 220 * h,
                                      child: Text(
                                        data[index].userName,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fontFamily,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14 * h,
                                          height: 1.5,
                                          color: AppTheme.black,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Дата поездки: ${data[index].date}",
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
