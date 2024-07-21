import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/core/errors/exceptions.dart';

abstract class AuthenticationClient {
  Future<UserCredential?> loginWithUserCredential(
      {required UserCredential? user});

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
  Future<UserCredential?> loginWithUserCredential(
      {required UserCredential? user}) async {
    try {
      if (user == null || user.credential == null) {
        throw const EmptyCacheException(message: 'No token provided');
      }
      final userCredential =
          await _firebaseAuth.signInWithCredential(user.credential!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message:
              e.message ?? "FirebaseAuthException signUpWithEmailAndPassword");
    }
  }
}
