import 'package:cooking_project/app/pages/login/login/cubit/login_state.dart';
import 'package:cooking_project/data/repository/login_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/use_cases/auth_use_case/auth_use_case.dart';

class LoginCubit extends Cubit<LoginState>{
  final LoginWithPhoneUseCase loginWithPhone;
  final LoginWithGoogleUseCase loginWithGoogle;
  final LoginWithFacebookUseCase loginWithFacebook;

  LoginCubit({
    required this.loginWithPhone,
    required this.loginWithGoogle,
    required this.loginWithFacebook,
  }) : super(LoginEmpty());

  void loginGoogle() async {
    emit(LoginLoading());
    try{
      var result = await loginWithGoogle();
      if(result ?? true){
        emit(LoginSuccess());
      }else{
        emit(LoginFail(error: 'Có lỗi xay ra'));
      }
    }catch(e){
      emit(LoginFail(error: e.toString()));
    }
  }

  void loginFacebook() async {
    emit(LoginLoading());
    try{
      var result = await loginWithFacebook();
      if(result ?? true){
        emit(LoginSuccess());
      }else{
        emit(LoginFail(error: 'Có lỗi xay ra'));
      }
    }catch(e){
      emit(LoginFail(error: e.toString()));
    }
  }

  void loginPhone({required String phoneNumber}) async {
    emit(LoginLoading());
    try{
      var verficationId = await loginWithPhone(phone: phoneNumber);
      emit(VerifyPhoneSuccess(verificationId: verficationId));
    }catch(e){
      emit(LoginFail(error: e.toString()));
    }
  }
}