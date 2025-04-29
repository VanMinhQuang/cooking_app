import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';

class LoginWithPhoneUseCase {
  final LoginRepository loginRepository;

  LoginWithPhoneUseCase({required this.loginRepository});

  Future<String> call({required String phone}) async {
    return await loginRepository.loginPhone(phone) ?? '';
  }
}