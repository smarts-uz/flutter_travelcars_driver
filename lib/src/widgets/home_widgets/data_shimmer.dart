import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/main.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_theme.dart';

class DataShimmer extends StatelessWidget {
  const DataShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Shimmer.fromColors(
      baseColor: AppTheme.shimmerBase,
      highlightColor: AppTheme.shimmerHighlight,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 20 * w, right: 20 * w, top: 20 * w),
            padding: EdgeInsets.symmetric(horizontal: 10 * w, vertical: 10 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10 * h),
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  height: 158 * h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 16 * h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20 * w, vertical: 20 * h),
            padding: EdgeInsets.symmetric(horizontal: 12 * w, vertical: 10 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 54 * h,
                  width: 200 * w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21 * h),
                    color: AppTheme.white,
                  ),
                ),
                SizedBox(
                  height: 10 * h,
                ),
                Container(
                  height: 120,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 12,
                    itemBuilder: (_, index) {
                      return Container(
                        height: 54 * h,
                        width: 200 * w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21 * h),
                          color: AppTheme.white,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
