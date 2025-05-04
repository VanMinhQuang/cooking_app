import 'package:cooking_project/app/pages/login/login/cubit/login_state.dart';
import 'package:cooking_project/data/repository/login_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/use_cases/auth_use_case/auth_use_case.dart';

class LoginCubit extends Cubit<LoginState>{
  final LoginWithPhoneUseCase _loginWithPhone;
  final LoginWithGoogleUseCase _loginWithGoogle;
  final LoginWithFacebookUseCase _loginWithFacebook;

  LoginCubit({
    required LoginWithPhoneUseCase loginWithPhone,
    required LoginWithGoogleUseCase loginWithGoogle,
    required LoginWithFacebookUseCase loginWithFacebook,
  })  : _loginWithPhone = loginWithPhone,
        _loginWithGoogle = loginWithGoogle,
        _loginWithFacebook = loginWithFacebook,
        super(LoginEmpty());

  void loginGoogle() async {
    emit(LoginLoading());
    try{
      var result = await _loginWithGoogle();
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
      var result = await _loginWithFacebook();
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
      var verficationId = await _loginWithPhone(phone: phoneNumber);
      emit(VerifyPhoneSuccess(verificationId: verficationId));
    }catch(e){
      emit(LoginFail(error: e.toString()));
    }
  }
}