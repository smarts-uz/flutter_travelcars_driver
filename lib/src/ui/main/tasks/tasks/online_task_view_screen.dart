import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/bloc/online_task_view_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/online_task_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/tasks/task_view_one.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/data_shimmer.dart';

import '../../../../utils/utils.dart';

class OnlineTaskViewScreen extends StatefulWidget {
  final String id;

  const OnlineTaskViewScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<OnlineTaskViewScreen> createState() => _OnlineTaskViewScreenState();
}

class _OnlineTaskViewScreenState extends State<OnlineTaskViewScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    onlineTaskBloc.getTask(widget.id);
    _tabController = TabController(length: 2, vsync: this);
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
      body: StreamBuilder(
        stream: onlineTaskBloc.oneTask,
        builder: (context, AsyncSnapshot<OnlineTaskModel> snapshot) {
          if (snapshot.hasData) {
            OnlineTaskModel data = snapshot.data!;
            return Column(
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
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30 * w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppTheme.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Текущая поездка".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 22 * h,
                          height: 26 / 22 * h,
                          color: AppTheme.white,
                        ),
                      ),
                      SizedBox(
                        width: 50 * w,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.only(left: 8 * w, right: 8 * w, top: 16 * h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21 * h),
                    color: AppTheme.lightGray,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 24 * w, vertical: 8 * h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: AppTheme.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.data.cityFrom,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 18 * h,
                            height: 26 / 18 * h,
                            color: AppTheme.black,
                          ),
                        ),
                        Text(
                          data.data.cityTo,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontSize: 14 * h,
                            height: 26 / 22 * h,
                            color: AppTheme.black,
                          ),
                        ),
                        Container(
                          height: 32 * h,
                          margin: EdgeInsets.only(
                            top: 16 * h,
                          ),
                          decoration: BoxDecoration(
                              color: AppTheme.white,
                              borderRadius: BorderRadius.circular(21 * h),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 10,
                                  color: Color.fromRGBO(0, 0, 0, 0.1),
                                )
                              ]),
                          child: TabBar(
                            physics: const NeverScrollableScrollPhysics(),
                            tabs: const [
                              Tab(
                                child: Text(
                                  'Заказчик',
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Детали поездки',
                                ),
                              ),
                            ],
                            controller: _tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(21 * h),
                              color: AppTheme.blue,
                            ),
                            padding: EdgeInsets.all(2 * h),
                            labelStyle: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 14 * h,
                              height: 1.5,
                              color: AppTheme.white,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontFamily: AppTheme.fontFamily,
                              fontWeight: FontWeight.normal,
                              fontSize: 14 * h,
                              height: 1.5,
                              color: AppTheme.blue,
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            unselectedLabelColor: AppTheme.black,
                            labelColor: AppTheme.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      TaskViewOneScreen(
                        data: data.data,
                      ),
                      TaskViewTwoScreen(
                        data: data.data,
                      ),
                    ],
                    controller: _tabController,
                  ),
                ),
              ],
            );
          } else {
            return const DataShimmer();
          }
        },
      ),
    );
  }
}
