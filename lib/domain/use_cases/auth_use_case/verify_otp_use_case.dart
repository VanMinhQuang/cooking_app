import '../../repositories/auth_repo/login_auth_repo.dart';

class VerifyOTPUseCase{
  final LoginRepository loginRepository;

  VerifyOTPUseCase({required this.loginRepository});

  Future<bool> call({required String otp, required String verificationId}) async {
    return await loginRepository.verifyOtp(otp: otp, verificationId: verificationId) ?? false;
  }
}