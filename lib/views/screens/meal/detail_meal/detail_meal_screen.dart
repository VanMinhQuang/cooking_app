import 'package:cooking_project/data/model/Food.dart';
import 'package:cooking_project/views/screens/meal/detail_meal/detail_meal_form.dart';
import 'package:flutter/cupertino.dart';

class DetailMealScreen extends StatelessWidget {
  Food? food;
   DetailMealScreen({this.food});


  @override
  Widget build(BuildContext context) {
    return DetailMealForm(food);
  }
}
