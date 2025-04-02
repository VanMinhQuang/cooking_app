import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginEmpty extends LoginState{}

class LoginLoading extends LoginState{}

class LoginSuccess extends LoginState{}

class LoginFail extends LoginState{}