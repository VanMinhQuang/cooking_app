import 'package:cooking_project/data/repository/meal_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/main_menu_searching_cubit.dart';
import 'main_menu_searching_form.dart';

class MainMenuSearchingScreen extends StatelessWidget {
  const MainMenuSearchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
        create: (context) => MainMenuCubit(),
        child: MainMenuSearchingForm());
  }
}
