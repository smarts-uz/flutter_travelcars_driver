import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';

import '../../../../utils/utils.dart';
import '../../../../widgets/profile_widget.dart';

class TaskViewOneScreen extends StatefulWidget {
  const TaskViewOneScreen({Key? key}) : super(key: key);

  @override
  _TaskViewOneScreenState createState() => _TaskViewOneScreenState();
}

class _TaskViewOneScreenState extends State<TaskViewOneScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = "Azizbek";
    _costController.text = "0";
    _statusController.text = "Не оплачено";
    _priceController.text = "Оценка: 0";
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
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: 8 * w,
              right: 8 * w,
              top: 16,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.lightGray,
            ),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 24 * w, vertical: 20 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: AppTheme.white,
              ),
              child: Column(
                children: [
                  getTextController(
                    context,
                    _nameController,
                    "Имя",
                  ),
                  getTextController(
                    context,
                    _costController,
                    "Стоимость поездки",
                  ),
                  getTextController(
                    context,
                    _statusController,
                    "Статус оплаты",
                  ),
                  getTextController(
                    context,
                    _priceController,
                    "Отзыв",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
