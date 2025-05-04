import 'package:cooking_project/data/model/user.dart';
import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object?> get props => [];
}

class SettingEmpty extends SettingState {}
class SettingLoading extends SettingState{}

class SettingError extends SettingState {
  String error;

  SettingError({required this.error});
}

class SettingChangeLocale extends SettingState {
  String locale;

  SettingChangeLocale({required this.locale});
}

class SettingIsAuthenticate extends SettingState {
  LocalUser? localUser;

  SettingIsAuthenticate({this.localUser});
}

class SettingLogout extends SettingState {}
