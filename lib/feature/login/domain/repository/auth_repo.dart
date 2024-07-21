import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>?> biometricLogin();

  Future<Either<Failure, bool>> deleteAccount();

  Future<Either<Failure, bool>> saveUserData(UserCredential? user);
}
