import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/core/errors/exceptions.dart';
import 'package:news_app_test/core/errors/failures.dart';
import 'package:news_app_test/feature/login/data/source/local/local_source.dart';
import 'package:news_app_test/feature/login/data/source/remote/remote_source.dart';
import 'package:news_app_test/feature/login/domain/repository/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthenticationClient _authRemoteSource;
  final AuthStorage _authLocalSource;
  const AuthRepositoryImpl(this._authRemoteSource, this._authLocalSource);

  @override
  Future<Either<Failure, bool>> deleteAccount() async {
    try {
      bool deleteAcc = await _authRemoteSource.deleteAccount();
      if (deleteAcc) {
        _authLocalSource.clearUserData();
      }
      return Right(deleteAcc);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  Future<Either<Failure, User>?> _loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      User? userdata = await _authRemoteSource.loginWithEmailAndPassword(
          email: email, password: password);
      if (userdata != null) {
        _authLocalSource.saveUserEmail(email);
        _authLocalSource.saveUserPassword(password);
        return Right(userdata);
      }
      return const Left(
          EmptyCacheFailure(message: 'No user found for that email.'));
    } on ServerException catch (e) {
      return Left(EmptyCacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>?> biometricLogin() async {
    try {
      String? email = await _authLocalSource.readUserEmail;
      String? password = await _authLocalSource.readUserPassword;
      if (email != null && password != null) {
        return _loginWithEmailAndPassword(email: email, password: password);
      }
      return const Left(
          EmptyCacheFailure(message: 'No user found. Try normal login first'));
    } catch (e) {
      return Left(EmptyCacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserData(
      String? email, String? password) async {
    try {
      if (email == null ||
          email.isEmpty ||
          password == null ||
          password.isEmpty) {
        return const Left(ServerFailure(
            message: "Data is missing. Please provide email and password"));
      }
      await _authLocalSource.saveUserEmail(email);
      await _authLocalSource.saveUserPassword(password);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
