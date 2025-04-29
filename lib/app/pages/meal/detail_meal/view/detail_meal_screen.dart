
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/meal_model.dart';
import '../cubit/detail_meal_cubit.dart';
import 'detail_meal_form.dart';

class DetailMealScreen extends StatelessWidget {
  String? heroTag;
  Meal? food;
   DetailMealScreen({super.key, this.food, this.heroTag});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DetailMealCubit(),
        child: DetailMealForm(food,heroTag));
  }
}
