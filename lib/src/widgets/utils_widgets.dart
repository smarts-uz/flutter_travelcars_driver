import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({
    Key? key,
    this.height = 1,
    this.color = AppTheme.gray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color.withOpacity(0.5)),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
