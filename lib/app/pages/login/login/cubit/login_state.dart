import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginEmpty extends LoginState{}

class LoginLoading extends LoginState{}

class LoginSuccess extends LoginState{}

class LoginFail extends LoginState{
  String? error;
  LoginFail({required this.error});
  @override
  List<Object> get props => [error ?? ''];
}

class VerifyPhoneSuccess extends LoginState{
  String? verificationId;
   VerifyPhoneSuccess({required this.verificationId});
  @override
  List<Object> get props => [verificationId ?? ''];
}