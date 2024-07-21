import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/core/errors/exceptions.dart';

abstract class AuthenticationClient {
  Future<User?> loginWithToken({required String? token});

  Future<bool> deleteAccount();
}

class AuthRemoteSource implements AuthenticationClient {
  AuthRemoteSource({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<bool> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const EmptyCacheException(message: 'No user to delete');
      }

      await user.delete();
      return true;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? "FirebaseAuthException deleteAccount");
    }
  }

  @override
  Future<User?> loginWithToken({required String? token}) async {
    try {
      if (token == null) {
        throw const EmptyCacheException(message: 'No token provided');
      }

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(token);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message:
              e.message ?? "FirebaseAuthException signUpWithEmailAndPassword");
    }
  }
}
