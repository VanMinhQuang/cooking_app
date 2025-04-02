import 'package:cooking_project/data/repository/login_repository.dart';
import 'package:cooking_project/views/screens/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState>{
  final LoginRepository loginRepository;
  LoginCubit({required this.loginRepository})  : super(LoginEmpty());

  void loginGoogle() async {
    emit(LoginLoading());
    try{
      var result = await loginRepository.loginWithGoogle();
    }catch(e){
      emit(LoginFail());
    }
  }
}