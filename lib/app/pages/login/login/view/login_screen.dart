
import 'package:cooking_project/core/singleton/injection_container.dart';
import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';
import 'package:cooking_project/domain/use_cases/auth_use_case/auth_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/repository/login_repository.dart';
import '../cubit/login_cubit.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginRepository = sl<LoginRepository>();
    return BlocProvider(create: (BuildContext context) {
      return LoginCubit(
        loginWithFacebook: LoginWithFacebookUseCase(loginRepository: loginRepository),
        loginWithGoogle: LoginWithGoogleUseCase(loginRepository: loginRepository),
        loginWithPhone: LoginWithPhoneUseCase(loginRepository: loginRepository)
      );
    },
    child: LoginForm());
  }
}
