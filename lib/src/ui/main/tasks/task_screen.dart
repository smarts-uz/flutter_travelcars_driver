import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/main.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/tasks/tasks_screen.dart';

import '../../../utils/utils.dart';

class TaskScreen extends StatefulWidget {
  final int index;

  const TaskScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Column(
        children: [
          Container(
            height: 32 * h,
            margin: EdgeInsets.symmetric(horizontal: 16 * w, vertical: 16 * h),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(21 * h),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 10,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                )
              ],
            ),
            child: Center(
              child: TabBar(
                physics: const NeverScrollableScrollPhysics(),
                tabs: const [
                  Tab(
                    child: Text(
                      'Обработанные',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Текущие',
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Pассмотрени',
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
                  overflow: TextOverflow.ellipsis,
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 14 * h,
                  height: 1.38 * h,
                  color: AppTheme.white,
                ),
                unselectedLabelStyle: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 14 * h,
                  height: 1.38 * h,
                  color: AppTheme.blue,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: AppTheme.black,
                labelColor: AppTheme.white,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                TasksScreen(
                  data: data,
                ),
                TasksScreen(
                  data: data,
                ),
                TasksScreen(
                  data: data,
                ),
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
