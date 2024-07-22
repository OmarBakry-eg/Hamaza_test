import 'package:dartz/dartz.dart';
import 'package:news_app_test/core/errors/failures.dart';
import 'package:news_app_test/feature/login/domain/repository/auth_repo.dart';

class SaveUserData {
  final AuthRepository authRepository;

  const SaveUserData({required this.authRepository});

  Future<Either<Failure, bool>?> call({
    required String email,
    required String password,
  }) async =>
      await authRepository.saveUserData(email, password);
}
