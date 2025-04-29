import 'package:cooking_project/app/pages/meal/detail_meal/widgets/detail_meal_header_image.dart';
import 'package:cooking_project/app/pages/meal/detail_meal/widgets/meal_detail_card.dart';
import 'package:cooking_project/domain/entities/meal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailMealForm extends StatefulWidget {
  final Meal? food;
  final String? heroTag;

  const DetailMealForm(this.food, this.heroTag, {super.key});

  @override
  State<DetailMealForm> createState() => _DetailMealFormState();
}

class _DetailMealFormState extends State<DetailMealForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Image and overlay section with a fixed height
            MealHeaderImage(
              imageUrl: widget.food!.image!,
              heroTag: widget.heroTag,
            ),

            // 2. Detail Card positioned below the fixed image height
            Transform.translate(
              offset: Offset(0, -50.sp), // Move the card up to overlap
              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: MealDetailCard(food: widget.food!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}