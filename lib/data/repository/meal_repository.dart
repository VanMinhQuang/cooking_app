import 'package:cooking_project/data/model/meal_model.dart';
import 'package:cooking_project/data/remote/meal_api.dart';

class MealRepository{
  final MealAPI mealAPI =  MealAPI();

  Future<List<Meal>?> getMeals () => mealAPI.getMeals();
}