import 'package:cooking_project/core/helper/screen_app.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/font_pro_awsome_icon.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/data/constant/constant_app.dart';
import 'package:cooking_project/data/model/daily_meal_model.dart';
import 'package:cooking_project/views/widgets/bar/main_app_bar.dart';
import 'package:cooking_project/views/widgets/dashboard_widgets/chart_calories.dart';
import 'package:cooking_project/views/widgets/dashboard_widgets/circle_percent_calories.dart';
import 'package:cooking_project/views/widgets/stuffs/components.dart';
import 'package:cooking_project/views/widgets/time_picker/date_picker_slide.dart';
import 'package:cooking_project/views/widgets/time_picker/week_picker_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

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
    // TODO: implement initState
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
        setState(() {}); // Trigger rebuild when tab changes
      }
    });
  }

  Widget _buildBoardInfo() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          padding: const EdgeInsets.only(top: 45),
          child: Card(
            elevation: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Use Container instead of Expanded
                Expanded(
                  flex: 4,
                  child: Container(
                    width:
                        MediaQuery.of(context).size.width * 0.4, // Adjust width
                    height: 160,
                    child: TodayCaloriesIndicator(
                      targetCalories: 2000,
                      actualCalories: 1300,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: Card(
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Xin chao ...",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomMealAppBar(isHaveSearchField: false,),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            _buildBoardInfo(),
            WeekPicker(
              initialDate: DateTime.now(),
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

            DatePickerSlide(initialDate: _selectedDate ?? DateTime.now(), onDateSelected: (dateSelected) => _selectedDate,),
            // TabBar
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: "Sang"),
                  Tab(text: "Trua"),
                  Tab(text: "Chieu"),
                  Tab(text: "Toi"),
                ],
              ),
            ),
            // Use IndexedStack instead of TabBarView to show content based on the selected tab
            IndexedStack(
              index: _tabController.index,
              children: [
                _buildMealMorning(),
                _buildMealNoon(),
                _buildMealEvening(),
                _buildMealSubMeal()
              ],
            ),
          ],
        ),
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
            _buildEnergyProgress(
                icon: proteinIcon,
                content: '123/280g',
                color: Colors.red,
                title: 'Protein'),
            _buildEnergyProgress(
                icon: carbIcon,
                content: '20/280g',
                color: Colors.yellow,
                title: 'Carb'),
            _buildEnergyProgress(
                icon: fatIcon,
                content: '4.2/20g',
                color: Colors.orange,
                title: 'Fat'),
            _buildEnergyProgress(
                icon: fiberIcon,
                content: '4.2/20g',
                color: colorPrimary,
                title: 'Fiber'),
          ],
        ),
      ),
    );
  }

  Widget _buildEnergyProgress(
      {required Image icon,
      required String content,
      required color,
      required String title}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LinearPercentIndicator(
          width: 80,
          animation: true,
          animationDuration: 1000,
          lineHeight: 10,
          leading: Container(
            height: 45,
            width: 45,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: icon,
          ),
          trailing: Text(
            content,
            style: TextThemeStyle.textSecondaryFontSizeBold(10),
          ),
          center: Text(title,
              style: TextThemeStyle.textSecondaryFontSizeBold(7,
                  color: Colors.black45)),
          percent: 0.2,
          progressColor: color,
          barRadius: Radius.circular(10),
        ),
      ],
    );
  }

  Widget _buildAddMealWidget() {
    return Container(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () async {},
          child: Card(
            borderOnForeground: true,
            elevation: 4,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        child: const Icon(Icons.add_circle,
                            size: 18, color: colorPrimary),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          'Them',
                          maxLines: 2,
                          style: TextThemeStyle.textBlackFontSizeBold16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildMealWidget() {
    return Container(
        padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () async {},
          child: Card(
            borderOnForeground: true,
            elevation: 4,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        child: const Icon(Icons.add_circle,
                            size: 18, color: colorPrimary),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          'Them',
                          maxLines: 2,
                          style: TextThemeStyle.textBlackFontSizeBold16,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildMealMorning() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMealWidget(),
        _buildMealWidget()
      ],
    );
  }

  Widget _buildMealNoon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildMealWidget(), _buildAddMealWidget()],
    );
  }

  Widget _buildMealEvening() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildMealWidget(), _buildAddMealWidget()],
    );
  }

  Widget _buildMealSubMeal() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildMealWidget(), _buildAddMealWidget()],
    );
  }
}
