import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/core/errors/failures.dart';
import 'package:news_app_test/feature/login/domain/repository/auth_repo.dart';

class BiometricUsecase {
  final AuthRepository authRepository;

  const BiometricUsecase({required this.authRepository});

  Future<Either<Failure, UserCredential>?> call() async => await authRepository.biometricLogin();
}
