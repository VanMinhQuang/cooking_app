import 'dart:async';
import 'dart:convert';

import 'package:cooking_project/core/service/service.dart';
import 'package:cooking_project/core/helper/shared_preferences.dart';
import 'package:cooking_project/data/model/user.dart';
import 'package:cooking_project/domain/repositories/auth_repo/login_auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginRepositoryImplement extends Service implements LoginRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final sl = GetIt.instance;

  @override
  Future<String?> loginPhone(String phoneNumber) async {
    try {
      final completer = Completer<String>();
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // If auto-verification works (rare case)
          var user = await _firebaseAuth.signInWithCredential(credential);
          var userMap = LocalUser(
              avatar: user.user?.photoURL,
              email: user.user?.email,
              displayName: user.user?.displayName,
              uid: user.user?.uid,
              token: user.user?.refreshToken);
          await SharedPrefsRepository().setString('User', jsonEncode(userMap));
          if (sl.isRegistered<LocalUser>()) {
            sl.unregister<LocalUser>();
          }
          sl.registerLazySingleton<LocalUser>(
                () => userMap,
          );

          completer.complete(''); // empty because auto verified
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError(e);
        },
        codeSent: (String verificationId, int? resendToken) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          completer.complete(verificationId);
        },
      );
      return completer.future;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool?> loginWithFacebook() async {
    try {
      // Trigger Facebook login
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        var user = await _firebaseAuth.signInWithCredential(credential);
        var userMap = LocalUser(
            avatar: user.user?.photoURL,
            email: user.user?.email,
            displayName: user.user?.displayName,
            uid: user.user?.uid,
            token: user.user?.refreshToken);
        await SharedPrefsRepository().setString('User', jsonEncode(userMap));
        if (sl.isRegistered<LocalUser>()) {
          sl.unregister<LocalUser>();
        }
        sl.registerLazySingleton<LocalUser>(
              () => userMap,
        );
        return true;
      }
      return false;
    } catch (e) {
      print("Facebook Sign-In Error: $e");
      return false;
    }
  }

  @override
  Future<bool?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return false;
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      var user = await _firebaseAuth.signInWithCredential(credential);
      var userMap = LocalUser(
          avatar: user.user?.photoURL,
          email: user.user?.email,
          displayName: user.user?.displayName,
          uid: user.user?.uid,
          token: user.user?.refreshToken);
      await SharedPrefsRepository().setString('User', jsonEncode(userMap));
      if (sl.isRegistered<LocalUser>()) {
        sl.unregister<LocalUser>();
      }
      sl.registerLazySingleton<LocalUser>(
            () => userMap,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool?> verifyOtp(
      {required String otp, required String verificationId}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );


      var user = await _firebaseAuth.signInWithCredential(credential);
      var userMap = LocalUser(
          avatar: user.user?.photoURL,
          email: user.user?.email,
          displayName: user.user?.displayName,
          uid: user.user?.uid,
          token: user.user?.refreshToken);
      await SharedPrefsRepository().setString('User', jsonEncode(userMap));
      if (sl.isRegistered<LocalUser>()) {
        sl.unregister<LocalUser>();
      }
      sl.registerLazySingleton<LocalUser>(
            () => userMap,
      );
      return true;
    } catch (e) {
      print("Phone Error: $e");
      return false;
    }
  }

}
