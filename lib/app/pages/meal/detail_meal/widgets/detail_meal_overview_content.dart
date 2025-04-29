
import 'package:cooking_project/app/pages/meal/detail_meal/widgets/detail_meal_info_item.dart';
import 'package:cooking_project/app/widgets/stuffs/text.dart';
import 'package:cooking_project/core/styles/color.dart';
import 'package:cooking_project/core/styles/text_theme.dart';
import 'package:cooking_project/domain/entities/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealOverviewContent extends StatelessWidget {
  final Meal food;
  final List<String> materials = [
    'Whole chicken - 1',
    'Potato - 500g',
    'Carrot - 300g',
    'Orange - 100g'
  ];

  MealOverviewContent({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Roasted Chicken',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Info items row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InfoItem(
                icon: Icons.timer_outlined,
                num: 120,
                type: 'TIME',
                textColor: colorWhite,
                boxColor: Colors.orange,
              ),
              InfoItem(
                icon: Icons.restaurant_menu,
                num: 5,
                type: 'STEP',
                textColor: colorWhite,
                boxColor: Colors.orange,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            'Roast chicken is a well‑known oven dish. Everyone may have their own recipe for pickling, but they want to bake crispy tips.',
            style: TextStyle(fontSize: 16.sp, color: Colors.grey[700]),
          ),

          const SizedBox(height: 10),

          // Categories/methods horizontal list
          _buildMethodsRow(),

          const SizedBox(height: 16),

          // Materials section
          Text(
            'Materials',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // Material items
          ...materials.map((item) => MaterialText(text: item)),

          SizedBox(height: 20.sp),

          // Start cooking button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50.sp),
              backgroundColor: colorPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.sp),
              ),
            ),
            child: Text(
              'Start Cooking',
              style: TextThemeStyle.textSecondaryFontSizeBold(18, color: colorWhite),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: food.method!.map((category) {
          return Container(
            margin: EdgeInsets.only(right: 8.sp),
            child: Chip(
              label: Text(
                category,
                style: TextThemeStyle.textSecondaryFontSizeBold(
                  14.sp,
                  color: colorWhite,
                ),
              ),
              backgroundColor: colorPrimary,
              shape: const StadiumBorder(side: BorderSide.none),
              visualDensity: VisualDensity.compact,
            ),
          );
        }).toList(),
      ),
    );
  }
}