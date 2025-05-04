import 'package:bloc/bloc.dart';
import 'package:cooking_project/app/pages/setting/cubit/setting_state.dart';
import 'package:cooking_project/core/helper/shared_preferences.dart';
import 'package:cooking_project/core/singleton/injection_container.dart';
import 'package:cooking_project/data/model/user.dart';
import 'package:cooking_project/domain/use_cases/auth_use_case/get_auth_status_use_case.dart';

class SettingCubit extends Cubit<SettingState>{
  final GetAuthStatusUseCase _getAuthStatusUseCase;
  SettingCubit({required GetAuthStatusUseCase getAuthUseCase}) : _getAuthStatusUseCase = getAuthUseCase, super(SettingEmpty());


  Future<LocalUser?> isAuthenticate() async{
    try{
      emit(SettingEmpty());
      var user = await _getAuthStatusUseCase();
      emit(SettingIsAuthenticate(localUser: user));
    }catch(e){
      emit(SettingError(error: e.toString()));
    }
  }

  Future<void> logOut() async{
    try{
      emit(SettingLoading());

      SharedPrefsRepository().setString('User', '');
      if (sl.isRegistered<LocalUser>()) {
        sl.unregister<LocalUser>();
      }
      emit(SettingLogout());
    }catch(e){
      emit(SettingError(error: e.toString()));
    }
  }
}