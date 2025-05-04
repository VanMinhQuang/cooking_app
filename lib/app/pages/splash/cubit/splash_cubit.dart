import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cooking_project/app/pages/splash/cubit/splash_state.dart';
import 'package:cooking_project/core/helper/General.dart';
import 'package:cooking_project/core/helper/shared_preferences.dart';
import 'package:cooking_project/core/singleton/injection_container.dart';
import 'package:cooking_project/data/model/user.dart';
import 'package:cooking_project/domain/use_cases/auth_use_case/get_auth_status_use_case.dart';

class SplashCubit extends Cubit<SplashState>{
  final GetAuthStatusUseCase _getAuthStatusUseCase;
  SplashCubit({required GetAuthStatusUseCase getAuthUseCase}) : _getAuthStatusUseCase = getAuthUseCase,super(SplashEmpty());


  void appStart()async {
    emit(SplashEmpty());
    await Future.delayed(const Duration(milliseconds: 200));
    await _getAuthStatusUseCase();
    emit(SplashDone());
  }

}