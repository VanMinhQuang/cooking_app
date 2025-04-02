import 'package:cooking_project/data/repository/login_repository.dart';
import 'package:cooking_project/views/screens/login/login_cubit.dart';
import 'package:cooking_project/views/screens/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) {
      return LoginCubit(loginRepository: LoginRepository());
    },
    child: LoginForm());
  }
}
