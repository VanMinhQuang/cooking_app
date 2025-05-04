
import 'package:cooking_project/app/pages/setting/cubit/setting_cubit.dart';
import 'package:cooking_project/app/pages/setting/view/setting_form.dart';
import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';
import 'package:cooking_project/domain/use_cases/auth_use_case/auth_use_case.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = 'SettingScreen';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginRepo = GetIt.instance<LoginRepository>();
    return BlocProvider(
        create: (context) => SettingCubit(getAuthUseCase: GetAuthStatusUseCase(loginRepository: loginRepo)),
        child: const SettingForm());
  }
}
