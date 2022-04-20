import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/profile_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_widget.dart';

class ProfileInfoWidget extends StatelessWidget {
  final double h;
  final double w;
  final ProfileModel data;

  const ProfileInfoWidget({
    Key? key,
    required this.h,
    required this.w,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: EdgeInsets.symmetric(horizontal: 24 * w, vertical: 20 * h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: AppTheme.white,
        ),
        child: Column(
          children: [
            getTextController(
              context,
              data.data.name,
              "Имя",
            ),
            getTextController(
              context,
              data.data.username,
              "Логин",
            ),
            getTextController(
              context,
              data.data.phone,
              "Телефон",
            ),
          ],
        ),
      ),
    );
  }
}
