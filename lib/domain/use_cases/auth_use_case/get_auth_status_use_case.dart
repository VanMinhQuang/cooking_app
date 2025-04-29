import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';

class GetAuthStatusUseCase {
  final LoginRepository loginRepository;

  GetAuthStatusUseCase({required this.loginRepository});

  Future<bool> call() async {
   return await loginRepository.isAuthenticate() ?? false;
  }
}