import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/src/core/errors/failures.dart';
import 'package:news_app_test/src/feature/login/domain/repository/auth_repo.dart';

class BiometricUsecase {
  final AuthRepository authRepository;

  const BiometricUsecase({required this.authRepository});

  Future<Either<Failure, User>?> call() async => await authRepository.biometricLogin();
}
