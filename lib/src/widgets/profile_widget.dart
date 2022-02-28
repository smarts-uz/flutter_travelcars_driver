import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import '../utils/utils.dart';

Widget getTextController(
  BuildContext context,
  TextEditingController _controller,
  String label,
) {
  double h = Utils.height(context);
  double w = Utils.width(context);
  return Column(
    children: [
      TextFormField(
        readOnly: true,
        controller: _controller,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 16 * h,
          height: 1.4 * h,
          color: AppTheme.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          label: Text(label),
          labelStyle: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 14 * h,
            height: 1.4 * h,
            color: AppTheme.gray,
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            border: Border.all(
          width: 1,
          color: AppTheme.lightGray,
        )),
      )
    ],
  );
}

Widget getTextEditController(
  BuildContext context,
  TextEditingController controller,
  String hint,
) {
  double h = Utils.height(context);
  double w = Utils.width(context);
  return Container(
    padding: EdgeInsets.symmetric(vertical: 0 * h, horizontal: 16 * w),
    margin: EdgeInsets.symmetric(vertical: 16 * h),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: AppTheme.bgTextFrom,
      border: Border.all(
        width: 1,
        color: AppTheme.blue,
      ),
      boxShadow: const [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 2,
          spreadRadius: 1,
          color: Color.fromRGBO(38, 39, 40, 0.2),
        ),
      ],
    ),
    child: Center(
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontFamily: AppTheme.fontFamily,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 16 * h,
          height: 1.2 * h,
          color: AppTheme.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 16 * h,
            height: 1.4 * h,
            color: const Color.fromRGBO(54, 69, 90, 0.2),
          ),
        ),
      ),
    ),
  );
}

Widget getButtonProfile(
    BuildContext context, String text, Function(int id) onChange) {
  double h = Utils.height(context);
  double w = Utils.width(context);
  return GestureDetector(
    onTap: (){
      onChange(0);
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 10 * h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: AppTheme.blue,
      ),
      child: Center(
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontFamily: AppTheme.fontFamily,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            fontSize: 16 * h,
            height: 24 / 16 * h,
            color: AppTheme.white,
          ),
        ),
      ),
    ),
  );
}
