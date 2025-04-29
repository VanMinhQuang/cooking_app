import 'package:cooking_project/app/pages/meal/detail_meal/cubit/detail_meal_cubit.dart';
import 'package:cooking_project/app/pages/meal/detail_meal/cubit/detail_meal_state.dart';
import 'package:cooking_project/app/pages/meal/detail_meal/widgets/detail_meal_overview_content.dart';
import 'package:cooking_project/app/pages/meal/detail_meal/widgets/detail_meal_step_content.dart';
import 'package:cooking_project/app/widgets/stuffs/indicator_dot.dart';
import 'package:cooking_project/domain/entities/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealDetailCard extends StatefulWidget {
  final Meal food;

  const MealDetailCard({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  State<MealDetailCard> createState() => _MealDetailCardState();
}

class _MealDetailCardState extends State<MealDetailCard> {
  late PageController _pageController;
  int _currentContentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20,
          ),
        ],
      ),
      child: BlocSelector<DetailMealCubit, DetailMealState, int>(
        selector: (state) {
          if (state is DetailMealIndexChange) {
            _currentContentIndex = state.index;
          }
          return _currentContentIndex;
        },
        builder: (BuildContext context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Indicator Dots
              IndicatorDots(currentIndex: _currentContentIndex),

              const SizedBox(height: 16),

              // Page content
              SizedBox(
                height: 500.sp,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    context.read<DetailMealCubit>().changeIndex(index);
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MealOverviewContent(food: widget.food),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MealStepsContent(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}