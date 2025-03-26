import 'package:cooking_project/data/repository/meal_repository.dart';
import 'package:cooking_project/views/screens/main_menu_searching/main_menu_searching_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_menu_searching_form.dart';

class MainMenuSearchingScreen extends StatelessWidget {
  const MainMenuSearchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create: (BuildContext context) {
      return MainMenuCubit(mealRepository: MealRepository());
    },
    child: MainMenuSearchingForm());
  }
}
