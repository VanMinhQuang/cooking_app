import 'package:cooking_project/views/screens/home/home_cubit.dart';
import 'package:cooking_project/views/screens/home/home_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit(),)
        ],
        child: HomeForm());
  }
}
