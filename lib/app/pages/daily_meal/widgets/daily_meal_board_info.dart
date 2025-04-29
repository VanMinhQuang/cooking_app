import 'package:cooking_project/app/pages/daily_meal/widgets/daily_meal_energy.dart';
import 'package:cooking_project/app/widgets/dashboard_widgets/circle_percent_calories.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class BoardInfo extends StatelessWidget {
  const BoardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.only(top: 45),
          child: Card(
            elevation: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: SizedBox(
                    height: 160.sp,
                    child: const TodayCaloriesIndicator(
                      targetCalories: 2000,
                      actualCalories: 1300,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EnergyProgress(
                          icon: proteinIcon,
                          content: '123/280g',
                          color: Colors.red,
                          title: 'Protein', percent: 0.2,),
                      EnergyProgress(
                          icon: carbIcon,
                          content: '20/280g',
                          color: Colors.yellow,
                          title: 'Carb', percent: 0.7,),
                      EnergyProgress(
                          icon: fatIcon,
                          content: '4.2/20g',
                          color: Colors.orange,
                          title: 'Fat', percent: 0.3,),
                      EnergyProgress(
                          icon: fiberIcon,
                          content: '4.2/20g',
                          color: colorPrimary,
                          title: 'Fiber', percent: 0.5,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Xin chào ...",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
