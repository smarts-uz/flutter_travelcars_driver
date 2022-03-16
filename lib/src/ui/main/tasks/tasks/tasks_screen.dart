import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/history_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/tasks/task_view_screen.dart';
import 'package:flutter_travelcars_driver/src/widgets/calendar_widget.dart';

import '../../../../bloc/history_bloc.dart';
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
  int page = 1;
  int last = 1;

  @override
  void initState() {
    historyBloc.getAllHistory(widget.type, page);
    scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (last >= page + 1) {
        page += 1;
        historyBloc.getAllHistory(widget.type, page);
        setState(() {});
      }
    }
    if (scrollController.position.pixels ==
        scrollController.position.minScrollExtent) {
      if (1 <= page - 1) {
        page -= 1;
        historyBloc.getAllHistory(widget.type, page);
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: StreamBuilder(
        stream: historyBloc.historyFeedback,
        builder: (context, AsyncSnapshot<HistoryModel> snapshot) {
          if (snapshot.hasData) {
            HistoryModel data = snapshot.data!;
            last = data.meta.lastPage;
            return data.data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.data.length,
                    controller: scrollController,
                    addAutomaticKeepAlives: false,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskViewScreen(
                                data: data.data[index],
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
                                  data.data[index].id.toString(),
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
                                      EdgeInsets.symmetric(horizontal: 16 * w),
                                  color:
                                      const Color.fromRGBO(235, 235, 235, 0.42),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 170,
                                          child: Text(
                                            data.data[index].car,
                                            style: TextStyle(
                                              fontFamily: AppTheme.fontFamily,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14 * h,
                                              height: 1.4,
                                              color: AppTheme.gray,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 6 * w,
                                        ),
                                        getCarNumber(
                                          context,
                                          Utils.getCarNumber(
                                              data.data[index].carNumber),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${data.data[index].cityFrom} - ${data.data[index].cityTo}",
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14 * h,
                                        height: 1.5,
                                        color: AppTheme.black,
                                      ),
                                    ),
                                    Text(
                                      data.data[index].userName,
                                      style: TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14 * h,
                                        height: 1.5,
                                        color: AppTheme.black,
                                      ),
                                    ),
                                    Text(
                                      "Дата поездки: ${data.data[index].date}",
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
                  )
                : const Center(
                    child: Text("Пустой"),
                  );
          } else {
            return const TaskShimmer();
          }
        },
      ),
    );
  }
}
