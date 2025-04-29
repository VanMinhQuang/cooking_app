import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cooking_project/core/styles/text_theme.dart';

class EnergyProgress extends StatelessWidget {
  final Image icon;
  final String content;
  final Color color;
  final String title;
  final double percent;

  const EnergyProgress({
    super.key,
    required this.icon,
    required this.content,
    required this.color,
    required this.title,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LinearPercentIndicator(
          width: 80.sp,
          animation: true,
          animationDuration: 1000,
          lineHeight: 10,
          leading: Container(
            height: 45.sp,
            width: 45.sp,
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
          trailing: Text(
            content,
            style: TextThemeStyle.textSecondaryFontSizeBold(10),
          ),
          center: Text(title,
              style: TextThemeStyle.textSecondaryFontSizeBold(7,
                  color: Colors.black45)),
          percent: percent,
          progressColor: color,
          barRadius: Radius.circular(10.sp),
        ),
      ],
    );
  }
}
