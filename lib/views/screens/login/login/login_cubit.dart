import 'package:cooking_project/data/repository/login_repository.dart';
import 'package:cooking_project/views/screens/login/login/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  final LoginRepository loginRepository;
  LoginCubit({required this.loginRepository})  : super(LoginEmpty());

  void loginGoogle() async {
    emit(LoginLoading());
    try{
      var result = await loginRepository.loginWithGoogle();
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
      var result = await loginRepository.loginWithFacebook();
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
      FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(LoginFail(error: e.toString()));
        },
        codeSent: (String verificationId, int? resendToken) {
          emit(VerifyPhoneSuccess(verificationId: verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeouts if needed
        },
      );
    }catch(e){
      emit(LoginFail(error: e.toString()));
    }
  }
}