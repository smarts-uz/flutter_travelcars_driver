import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/tasks/tasks_screen.dart';

import '../../../bloc/history_bloc.dart';
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
  List<String> typeData = ["done", "active"];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
            margin: EdgeInsets.symmetric(horizontal: 12 * w, vertical: 16 * h),
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
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Текущие',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                controller: _tabController,
                onTap: (s) {
                  //historyBloc.getAllHistory(typeData[_tabController!.index], 1);
                },
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(21 * h),
                  color: AppTheme.blue,
                ),
                padding: const EdgeInsets.all(1),
                labelStyle: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 14 * h,
                  height: 1.38 * h,
                  color: AppTheme.white,
                ),
                unselectedLabelStyle: TextStyle(
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
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                TasksScreen(
                  type: typeData[0],
                ),
                TasksScreen(
                  type: typeData[1],
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
