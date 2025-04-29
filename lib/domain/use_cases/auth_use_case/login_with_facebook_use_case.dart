import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';

class LoginWithFacebookUseCase {
  final LoginRepository loginRepository;

  LoginWithFacebookUseCase({required this.loginRepository});

  Future<bool?> call() async {
   return await loginRepository.loginWithFacebook();
  }
}