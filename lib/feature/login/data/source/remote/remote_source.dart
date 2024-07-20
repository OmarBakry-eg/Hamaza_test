import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:news_app_test/core/errors/exceptions.dart';
import 'package:news_app_test/feature/login/data/model/auth_user.dart';

abstract class AuthenticationClient {
  Stream<AuthenticationUser> get user;
  Future<bool> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<bool> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<bool> logOut();

  Future<bool> deleteAccount();
}

class FirebaseAuthenticationClient implements AuthenticationClient {
  FirebaseAuthenticationClient({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;

  @override
  Stream<AuthenticationUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthenticationUser.anonymous
          : firebaseUser.toUser;
    });
  }

  @override
  Future<bool> logOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? "FirebaseAuthException logOut");
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw const EmptyCacheException(message: 'No user to delete');
      }

      await user.delete();
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw ServerException(
          message: e.message ?? "FirebaseAuthException deleteAccount");
    }
  }

  @override
  Future<bool> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user?.sendEmailVerification();
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw ServerException(
          message:
              e.message ?? "FirebaseAuthException signUpWithEmailAndPassword");
    }
  }

  @override
  Future<bool> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user?.sendEmailVerification();
      return true;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw ServerException(
          message:
              e.message ?? "FirebaseAuthException signUpWithEmailAndPassword");
    }
  }

  // /// Updates the user token in [TokenStorage] if the user is authenticated.
  // Future<void> _onUserChanged(AuthenticationUser user) async {
  //   if (!user.isAnonymous) {
  //     await _tokenStorage.saveToken(user.id);
  //   } else {
  //     await _tokenStorage.clearToken();
  //   }
  // }
}

extension on firebase_auth.User {
  AuthenticationUser get toUser {
    return AuthenticationUser(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
      isNewUser: metadata.creationTime == metadata.lastSignInTime,
    );
  }
}
