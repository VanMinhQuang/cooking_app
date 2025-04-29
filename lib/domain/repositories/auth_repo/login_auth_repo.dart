abstract class LoginRepository{
  Future<bool?> loginWithFacebook();
  Future<bool?> loginWithGoogle();
  Future<String?> loginPhone(String phoneNumber);
  Future<bool?> verifyOtp({required String otp, required String verificationId});
  Future<bool?> isAuthenticate();
}