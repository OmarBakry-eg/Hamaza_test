import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/src/core/errors/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>?> biometricLogin();

  Future<Either<Failure, bool>> deleteAccount();

  Future<Either<Failure, bool>> saveUserData(String? email, String? password);
}
