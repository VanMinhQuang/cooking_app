import 'package:cooking_project/core/helper/screen_app.dart';
import 'package:cooking_project/core/styles/font_pro_awsome_icon.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:cooking_project/data/model/daily_meal_model.dart';
import 'package:cooking_project/views/widgets/bar/main_app_bar.dart';
import 'package:cooking_project/views/widgets/dashboard_widgets/chart_calories.dart';
import 'package:cooking_project/views/widgets/dashboard_widgets/circle_percent_calories.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyMealForm extends StatefulWidget {
  const DailyMealForm({super.key});

  @override
  State<DailyMealForm> createState() => _DailyMealFormState();
}

class _DailyMealFormState extends State<DailyMealForm> {
  final _listFlSpotActualCalories = <FlSpot>[];
  final _listFlSpotTargetCalories = <FlSpot>[];

  late DailyMeal dailyMeal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dailyMeal = DailyMeal.generateData();

    for (int i = 0; i < dailyMeal.listCalories!.length; i++) {
      var data = dailyMeal.listCalories![i];
      _listFlSpotTargetCalories.add(FlSpot(i.toDouble(), data.target ?? 0));
      _listFlSpotActualCalories.add(FlSpot(i.toDouble(), data.actual ?? 0));
    }
  }

  BoxDecoration softDecoration({
    Color bgColor = const Color(0xFFDDE4D2),
    double blur = 10.0,
    Offset offset1 = const Offset(-5, -5),
    Offset offset2 = const Offset(5, 5),
  }) {
    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.white.withOpacity(0.8),
          offset: offset1,
          blurRadius: blur,
        ),
        BoxShadow(
          color: Colors.black12,
          offset: offset2,
          blurRadius: blur,
        ),
      ],
    );
  }

  Widget softButton(IconData icon, {double size = 40}) {
    return Container(
      height: size,
      width: size,
      decoration: softDecoration(),
      child: Icon(icon, size: 24, color: Colors.grey[700]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMealAppBar(),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                padding: const EdgeInsets.only(top: 40),
                child: Card(
                  elevation: 4,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Use Container instead of Expanded
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: MediaQuery.of(context).size.width *
                              0.4, // Adjust width
                          height: 160,
                          child: TodayCaloriesIndicator(
                            targetCalories: 2000,
                            actualCalories: 1300,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _buildTitleCircle('asdasd'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Xin chao ...",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    height: 300,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DashboardCaloriesChart(
                          listCaloriesActual: _listFlSpotActualCalories,
                          listCaloriesTarget: _listFlSpotTargetCalories,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DashboardCaloriesChart(
                          listCaloriesActual: _listFlSpotActualCalories,
                          listCaloriesTarget: _listFlSpotTargetCalories,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleCircle(String text) {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Card(
        elevation: 3,
         //   margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(8.0),
                      // Optional padding
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent, // Background color for the icon
                      ),
                      child: proteinIcon,
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Text('12500',
                      style: TextThemeStyle.textSecondaryFontSizeBold(15),
                      ))
                ],
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.all(8.0),
                    // Optional padding
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent, // Background color for the icon
                    ),
                    child: carbIcon,
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Text('12500',
                      style: TextThemeStyle.textSecondaryFontSizeBold(15),
                    ))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.all(8.0),
                    // Optional padding
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent, // Background color for the icon
                    ),
                    child: fatIcon,
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Text('12500',
                      style: TextThemeStyle.textSecondaryFontSizeBold(15),
                    ))
              ],
            ),
      
          ],
        ),
      ),
    );
  }
}
