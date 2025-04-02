import 'package:cooking_project/core/service/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
}