import 'package:cooking_project/app/pages/daily_meal/widgets/daily_meal_section.dart';
import 'package:cooking_project/app/widgets/bar/main_app_bar.dart';
import 'package:cooking_project/app/widgets/dashboard_widgets/chart_calories.dart';
import 'package:cooking_project/app/widgets/time_picker/date_picker_slide.dart';
import 'package:cooking_project/app/widgets/time_picker/week_picker_widget.dart';
import 'package:cooking_project/core/enum/MealType.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cooking_project/domain/entities/daily_meal_model.dart';

import '../widgets/daily_meal_widgets.dart';



class DailyMealForm extends StatefulWidget {
  const DailyMealForm({super.key});

  @override
  State<DailyMealForm> createState() => _DailyMealFormState();
}

class _DailyMealFormState extends State<DailyMealForm>
    with SingleTickerProviderStateMixin {
  final _listFlSpotActualCalories = <FlSpot>[];
  final _listFlSpotTargetCalories = <FlSpot>[];
  DateTime? _selectedDate;
  late DailyMeal dailyMeal;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    dailyMeal = DailyMeal.generateData();
    _tabController = TabController(length: 4, vsync: this);

    for (int i = 0; i < dailyMeal.listCalories!.length; i++) {
      var data = dailyMeal.listCalories![i];
      _listFlSpotTargetCalories.add(FlSpot(i.toDouble(), data.target ?? 0));
      _listFlSpotActualCalories.add(FlSpot(i.toDouble(), data.actual ?? 0));
    }

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMealAppBar(isHaveSearchField: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoardInfo(),
            WeekPicker(initialDate: DateTime.now()),
            Container(
              height: 300.sp,
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
            DatePickerSlide(
              initialDate: _selectedDate ?? DateTime.now(),
              onDateSelected: (dateSelected) => _selectedDate,
            ),
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Sang"),
                Tab(text: "Trua"),
                Tab(text: "Chieu"),
                Tab(text: "Toi"),
              ],
            ),
            IndexedStack(
              index: _tabController.index,
              children: [
                MealSection(type: MealType.morning),
                MealSection(type: MealType.noon),
                MealSection(type: MealType.evening),
                MealSection(type: MealType.sub),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
