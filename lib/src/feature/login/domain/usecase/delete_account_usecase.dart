import 'package:dartz/dartz.dart';
import 'package:news_app_test/src/core/errors/failures.dart';
import 'package:news_app_test/src/feature/login/domain/repository/auth_repo.dart';

class DeleteAccount {
  final AuthRepository authRepository;

  const DeleteAccount({required this.authRepository});

  Future<Either<Failure, bool>> call() async =>
      await authRepository.deleteAccount();
}
