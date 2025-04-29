import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';

class LoginWithGoogleUseCase {
  final LoginRepository loginRepository;

  LoginWithGoogleUseCase({required this.loginRepository});

  Future<bool?> call() async {
   return await loginRepository.loginWithGoogle();
  }
}