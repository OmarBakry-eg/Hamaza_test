import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/core/errors/exceptions.dart';
import 'package:news_app_test/core/errors/failures.dart';
import 'package:news_app_test/core/util/logger.dart';
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

  Future<Either<Failure, UserCredential>?> _loginWithUserCredential(
      {required UserCredential? user}) async {
    try {
      UserCredential? userdata =
          await _authRemoteSource.loginWithUserCredential(user: user);
      if (userdata != null && userdata.credential != null) {
        Logger.logWarning("map : ${userdata.credential?.asMap()}");
        //_authLocalSource.saveUserData();
        return Right(userdata);
      }
      return const Left(
          EmptyCacheFailure(message: 'No user found for that email.'));
    } on ServerException catch (e) {
      return Left(EmptyCacheFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserCredential>?> biometricLogin() async {
    try {
      // UserCredential? user = await _authLocalSource.readUserData;
      // if (token != null && token.isNotEmpty) {
      //   return _loginWithToken(token: token);
      // }
      return const Left(
          EmptyCacheFailure(message: 'No user found. Try normal login first'));
    } catch (e) {
      return Left(EmptyCacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> saveUserData(UserCredential? user) async {
    try {
      if (user == null || user.credential == null) {
        return const Left(
            ServerFailure(message: "No token provided from firebase"));
      }
     // await _authLocalSource.saveUserData(token);
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
