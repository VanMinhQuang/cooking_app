import 'package:cooking_project/data/remote/login_api.dart';

class LoginRepository{
  final LoginApi loginApi = LoginApi();
  Future<bool?> loginWithGoogle() async {
    return await loginApi.loginWithGoogle();
  }
}