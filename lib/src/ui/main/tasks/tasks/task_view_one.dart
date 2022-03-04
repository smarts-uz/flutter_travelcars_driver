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
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _costController = TextEditingController();
  // final TextEditingController _statusController = TextEditingController();
  // final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Заказчик",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18 * h,
                      height: 1.4 * h,
                      color: AppTheme.black,
                    ),
                  ),
                  getTextController(
                    context,
                    "Azizbek",
                    "Имя",
                  ),
                  getTextController(
                    context,
                    "0",
                    "Стоимость поездки",
                  ),
                  getTextController(
                    context,
                    "Не оплачено",
                    "Статус оплаты",
                  ),
                  getTextController(
                    context,
                    "Оценка: 0",
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

class TaskViewTwoScreen extends StatefulWidget {
  const TaskViewTwoScreen({Key? key}) : super(key: key);

  @override
  _TaskViewTwoScreenState createState() => _TaskViewTwoScreenState();
}

class _TaskViewTwoScreenState extends State<TaskViewTwoScreen> {
  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _costController = TextEditingController();
  // final TextEditingController _statusController = TextEditingController();
  // final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
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
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Детали поездки",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 18 * h,
                      height: 1.4 * h,
                      color: AppTheme.black,
                    ),
                  ),
                  getTextController(
                    context,
                    "Chevrolet Equinox (01R444RR)",
                    "Авто",
                  ),
                  getTextController(
                    context,
                    "28.02.2022",
                    "Дата поездки",
                  ),
                  getTextController(
                    context,
                    "Ташкент",
                    "Пункт А",
                  ),
                  getTextController(
                    context,
                    "Экскурсия по городу",
                    "Пункт Б",
                  ),
                  getTextController(
                    context,
                    "Нет комментариев",
                    "Комментарий клиента",
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
