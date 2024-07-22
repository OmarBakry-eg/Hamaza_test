import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/src/core/errors/exceptions.dart';

abstract class AuthenticationClient {
  Future<User?> loginWithEmailAndPassword(
      {required String email, required String password});

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
  Future<User?> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw ServerException(
          message:
              e.message ?? "FirebaseAuthException signUpWithEmailAndPassword");
    }
  }
}
