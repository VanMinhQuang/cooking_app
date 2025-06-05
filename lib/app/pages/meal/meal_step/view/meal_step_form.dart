import 'package:cooking_project/app/pages/meal/meal_step/widgets/meal_step_video.dart';
import 'package:cooking_project/app/widgets/button/navigation_button.dart';
import 'package:cooking_project/app/widgets/mixin/base_mixin.dart';
import 'package:cooking_project/core/helper/screen_app.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/domain/entities/meal_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'dart:async';

class MealStepForm extends StatefulWidget {
  const MealStepForm({super.key});

  @override
  State<MealStepForm> createState() => _MealStepFormState();
}

class _MealStepFormState extends State<MealStepForm> with BaseMixin {
  final PageController _controller = PageController();
  int _currentStep = 0;
  List<MealStep> lstStep = [];
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _stepStarted = false;

  @override
  void initState() {
    super.initState();
    lstStep = MealStep.mockMealSteps;
    _stepStarted = false;
    // Timer will start only after pressing the button
  }

  void _startTimerForStep(int index) {
    _timer?.cancel();
    final step = lstStep[index];
    setState(() {
      _remainingSeconds = step.time ?? 0;
      _stepStarted = true;
    });
    if (_remainingSeconds > 0 && !(step.isDone ?? false)) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingSeconds > 0) {
          setState(() {
            _remainingSeconds--;
          });
        } else {
          _timer?.cancel();
          _markStepDoneAndNext(index);
        }
      });
    }
  }

  void _markStepDoneAndNext(int index) {
    setState(() {
      lstStep[index].isDone = true;
    });
    if (index < lstStep.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentStep = index;
      _stepStarted = false;
    });
    _timer?.cancel();
    // Timer will start only after pressing the button
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(),
          Positioned(
            top: MediaQuery.of(context).padding.top + 5.sp,
            left: 16.sp,
            child: NavigationButton(
              icon: Icons.arrow_back,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 32.sp,
            ),
            child: PageView.builder(
              controller: _controller,
              onPageChanged: _onPageChanged,
              itemCount: lstStep.length,
              itemBuilder: (context, index) {
                var step = lstStep[index];
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      stepCounter(index, step),
                      if (step.videoUrl != null && step.videoUrl!.isNotEmpty)
                        StepVideo(videoUrl: step.videoUrl!),
                      stepDescr(step.descr ?? ''),
                      ((step.listRecipe?.length ?? 0) > 0) ? stepListRecipeCard(step) : const SizedBox.shrink(),
                      (step.time ?? 0) > 0 ?  _buildTimer(index) : const SizedBox.shrink(),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 40.sp,
            child: buttonFinish(lstStep[_currentStep]),
          ),
        ],
      ),
    );
  }

  Widget stepCounter(int index, MealStep step) {
    return Container(
      margin: EdgeInsets.only(top: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: Divider(thickness: 2, endIndent: 10)),
          CircleAvatar(
            radius: 40,
            backgroundColor: colorPrimary,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: step.isDone ?? false
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 32.sp,
                    )
                  : Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 32.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const Expanded(child: Divider(thickness: 2, indent: 10)),
        ],
      ),
    );
  }

  Widget _buildTimer(int index) {
    final totalSeconds = lstStep[index].time ?? 0;
    final isDone = lstStep[index].isDone ?? false;
    final isCurrent = _currentStep == index;
    final seconds = isCurrent ? _remainingSeconds : totalSeconds;
    if (isDone) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          border: Border.all(color: Colors.white, width: 2.sp),
        ),
        padding: EdgeInsets.all(10.sp),
        child: Text('Completed', style: TextStyle(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold)),
      );
    }
    if (totalSeconds == 0) {
      return SizedBox.shrink();
    }
    if (!_stepStarted && isCurrent) {
      return Padding(
        padding: EdgeInsets.only(top: 10.sp),
        child: ElevatedButton(
          onPressed: () => _startTimerForStep(index),
          child: Text('Start Step', style: TextStyle(fontSize: 18.sp)),
        ),
      );
    }
    double percent = totalSeconds > 0 ? seconds / totalSeconds : 0;
    return Padding(
      padding: EdgeInsets.only(top: 10.sp),
      child: CircularPercentIndicator(
        radius: 100.sp,
        lineWidth: 12,
        percent: 1 - percent,
        backgroundColor: percent > 0.5 ? Colors.blue.withOpacity(0.3) : percent > 0.3 ? Colors.orange.withOpacity(0.3) : Colors.red.withOpacity(0.3),
        progressColor: percent > 0.5 ? Colors.blue : percent > 0.3 ? Colors.orange : Colors.red,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          _formatTime(seconds),
          style: TextStyle(fontSize: 28.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        animateFromLastPercent: true,
        animation: true,
        animationDuration: 500,
      ),
    );
  }

  String _formatTime(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  Widget stepDescr(String title) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
        child: Text(title,
            style: TextThemeStyle.textSecondaryFontSizeBold(18.sp,
                color: Colors.white)),
      ),
    );
  }

  Widget stepListRecipeCard(MealStep step){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.sp,horizontal: 20.sp),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: step.listRecipe!.map((recipe) {
            return Container(
              margin: EdgeInsets.only(right: 8.sp),
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 4.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp),
                color: colorWhite,
              ),
              child: Text('${recipe.recipe?.recipeName ?? ''}: ${recipe.gram}g',
                  style: TextThemeStyle.textSecondaryFontSizeBold(
                    14.sp,
                    color: colorPrimary,
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buttonFinish(MealStep step) {
    return Container(
      height: 80.sp,
      width: ScreenApp.screenWidth,
      padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
      child: ElevatedButton(

        onPressed: () {
          step.isDone = true;
          if (_currentStep < lstStep.length - 1) {
            _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
          } else {
            Navigator.of(context).pop(); // Navigate back or to another page
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.sp),
          ),

        ),
        child: Text('Finish', style: TextThemeStyle.textSecondaryFontSizeBold(25,color: colorWhite)),
      ),
    );
  }
}
