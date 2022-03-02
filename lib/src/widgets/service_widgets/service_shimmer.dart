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
              color: AppTheme.white,
            ),
          )
        ],
      ),
    );
  }
}
