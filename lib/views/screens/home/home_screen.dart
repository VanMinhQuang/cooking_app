import 'package:cooking_project/data/model/meal_model.dart';
import 'package:cooking_project/data/repository/meal_repository.dart';
import 'package:cooking_project/views/screens/home/home_cubit.dart';
import 'package:cooking_project/views/screens/home/home_form.dart';
import 'package:cooking_project/views/screens/main_menu_searching/main_menu_searching_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit(),),
        ],
        child: HomeForm());
  }
}
