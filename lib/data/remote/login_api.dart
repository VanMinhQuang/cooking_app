import 'package:cooking_project/core/service/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class LoginApi extends Service{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  Future<bool?> loginWithGoogle() async {
    try{
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if(account == null) return false;
      final GoogleSignInAuthentication googleAuth = await account.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      return true;
    }catch(e){
      rethrow;
    }
  }

  Future<bool?> loginWithFacebook() async {
    try {
      // Trigger Facebook login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
         await _auth.signInWithCredential(credential);
         return true;
      }
      return false;
    } catch (e) {
      print("Facebook Sign-In Error: $e");
      return false;
    }

  }

  Future<bool?> verifyOtp({required String otp, required String verificationId}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);

      return true;
    } catch (e) {
      print("Phone Error: $e");
      return false;
    }

  }


}