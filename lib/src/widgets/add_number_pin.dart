
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';

import '../utils/utils.dart';

class AddNumber extends StatefulWidget {
  final String number;
  final Function() onTap;

  AddNumber({
    required this.number,
    required this.onTap,
  });

  @override
  _AddNumberState createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    return Container(
      height: 64 * h,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16 * h),
        border: Border.all(
          width: 2 * h,
          color: AppTheme.lightGray,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16 * h),
          onTap: (){
            widget.onTap();
          },
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Text(
                widget.number,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 24 * h,
                  color: AppTheme.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
