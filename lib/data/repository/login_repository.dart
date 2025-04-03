import 'package:cooking_project/data/remote/login_api.dart';

class LoginRepository{
  final LoginApi loginApi = LoginApi();
  Future<bool?> loginWithGoogle() async {
    return await loginApi.loginWithGoogle();
  }


  Future<bool?> loginWithFacebook() async {
    return loginApi.loginWithFacebook();
  }


  Future<bool?> verifyOtp({required String otp, required String verificationId}){
    return loginApi.verifyOtp(otp: otp, verificationId: verificationId);
  }

}