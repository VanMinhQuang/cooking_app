import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TodayCaloriesIndicator extends StatelessWidget {
  final double targetCalories;
  final double actualCalories;

  const TodayCaloriesIndicator({
    super.key,
    required this.targetCalories,
    required this.actualCalories,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (actualCalories / targetCalories).clamp(0.0, 1.0);

    return CircularPercentIndicator(
      radius: 60,
      lineWidth: 12.0,
      animation: true,
      percent: percent,
      center: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${(percent * 100).toInt()}%",
            style: TextThemeStyle.textBlackFontSizeBold16,
          ),
          const SizedBox(height: 4),
          Text(
            "${actualCalories.toInt()} / ${targetCalories.toInt()}",
            style: TextThemeStyle.textBlackNoWeightCustomSize(12),
          ),
        ],
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: colorPrimary,
      backgroundColor: Colors.grey.shade300,
    );
  }
}