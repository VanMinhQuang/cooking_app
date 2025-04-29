import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealStepsContent extends StatelessWidget {
  // Steps data could be passed from the parent or fetched from a model
  final List<Map<String, String>> _steps = [
    {
      'title': 'Step 1: Prepare Ingredients',
      'description':
      'Gather all the necessary ingredients: chicken, potatoes, carrots, and oranges.'
    },
    {
      'title': 'Step 2: Season the Chicken',
      'description': 'Rub the chicken with your favorite spices and herbs.'
    },
    {
      'title': 'Step 3: Roast the Vegetables',
      'description':
      'Toss the potatoes and carrots with oil and seasoning, then place them around the chicken.'
    },
    {
      'title': 'Step 4: Bake',
      'description':
      'Preheat the oven and bake the chicken and vegetables until cooked through.'
    },
    {
      'title': 'Step 5: Serve',
      'description':
      'Let the chicken rest for a few minutes before carving and serving with the roasted vegetables and orange slices.'
    },
  ];

  MealStepsContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _steps.length,
      itemBuilder: (BuildContext context, int index) {
        final step = _steps[index];
        return _buildStepItem(step);
      },
    );
  }

  Widget _buildStepItem(Map<String, String> step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            step['title']!,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            step['description']!,
            style: TextStyle(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}