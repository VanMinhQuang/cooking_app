import 'dart:convert';

import 'package:cooking_project/core/helper/shared_preferences.dart';
import 'package:cooking_project/core/singleton/injection_container.dart';
import 'package:cooking_project/data/model/user.dart';
import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';

class GetAuthStatusUseCase {
  final LoginRepository loginRepository;

  GetAuthStatusUseCase({required this.loginRepository});

  Future<LocalUser?> call() async {
    var userJson = SharedPrefsRepository().getString('User');
    if (userJson.isEmpty) {
      return null;
    } else {
      var user = LocalUser.fromJson(jsonDecode(userJson));
      if (sl.isRegistered<LocalUser>()) {
        sl.unregister<LocalUser>();
      }
      sl.registerLazySingleton<LocalUser>(
            () => user,
      );
      return user;
    }
  }
}