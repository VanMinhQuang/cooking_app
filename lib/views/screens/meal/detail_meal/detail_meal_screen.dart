import 'package:cooking_project/data/model/meal_model.dart';
import 'package:cooking_project/views/screens/meal/detail_meal/detail_meal_form.dart';
import 'package:flutter/cupertino.dart';

class DetailMealScreen extends StatelessWidget {
  String? heroTag;
  Meal? food;
   DetailMealScreen({super.key, this.food, this.heroTag});


  @override
  Widget build(BuildContext context) {
    return DetailMealForm(food,heroTag);
  }
}
