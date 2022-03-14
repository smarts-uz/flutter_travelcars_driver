import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_theme.dart';
import '../../utils/utils.dart';

class ServiceShimmer extends StatelessWidget {
  const ServiceShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Shimmer.fromColors(
      baseColor: AppTheme.shimmerBase,
      highlightColor: AppTheme.shimmerHighlight,
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: 16 * w, vertical: 16 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21 * h),
                color: AppTheme.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TaskShimmer extends StatelessWidget {
  const TaskShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Shimmer.fromColors(
      baseColor: AppTheme.shimmerBase,
      highlightColor: AppTheme.shimmerHighlight,
      child: ListView.builder(
        itemCount: 15,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 24 * w, vertical: 6 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppTheme.white,
            ),
          );
        },
      ),
    );
  }
}
