import 'package:cooking_project/app/pages/main_menu_searching/widgets/meal_carousel/animated_meal_carousel.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/meal_model.dart';
import '../../../widgets/stuffs/components.dart';
import 'meal_card.dart';

class MealList extends StatelessWidget {
  final List<Meal> meals;
  final VoidCallback onFetchMore;

  const MealList({
    super.key,
    required this.meals,
    required this.onFetchMore,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 440,
      child: AnimatedCardsCarousel(
        onFetchMore: onFetchMore,
        cardsList: List.generate(
          meals.length,
              (index) {
            final meal = meals[index];
            return CategoryCard(
              imageUrl: meal.image ?? '',
              title: meal.mealName ?? '',
            );
          },
        ),
      ),
    );
  }
}
