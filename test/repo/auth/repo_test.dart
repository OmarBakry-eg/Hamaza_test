import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app_test/src/core/errors/exceptions.dart';
import 'package:news_app_test/src/core/errors/failures.dart';
import 'package:news_app_test/src/feature/login/data/repository/repo.dart';
import 'package:news_app_test/src/feature/login/data/source/local/local_source.dart';
import 'package:news_app_test/src/feature/login/data/source/remote/remote_source.dart';

class MockAuthRemoteSource extends Mock implements AuthenticationClient {}
class MockAuthLocalSource extends Mock implements AuthStorage {}
class MockUser extends Mock implements User {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteSource mockAuthRemoteSource;
  late MockAuthLocalSource mockAuthLocalSource;

  setUp(() {
    mockAuthRemoteSource = MockAuthRemoteSource();
    mockAuthLocalSource = MockAuthLocalSource();
    repository = AuthRepositoryImpl(mockAuthRemoteSource, mockAuthLocalSource);
  });

  group('deleteAccount', () {
    test('should delete account and clear user data when remote source is successful', () async {
      // Arrange
      when(() => mockAuthRemoteSource.deleteAccount())
          .thenAnswer((_) async => true);
      when(() => mockAuthLocalSource.clearUserData())
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.deleteAccount();

      // Assert
      verify(() => mockAuthRemoteSource.deleteAccount());
      verify(() => mockAuthLocalSource.clearUserData());
      expect(result, equals(const Right(true)));
    });

    test('should return ServerFailure when the call to remote source is unsuccessful', () async {
      // Arrange
      when(() => mockAuthRemoteSource.deleteAccount())
          .thenThrow(ServerException(message: 'Server Error'));

      // Act
      final result = await repository.deleteAccount();

      // Assert
      verify(() => mockAuthRemoteSource.deleteAccount());
      expect(result, equals(const Left(ServerFailure(message: 'Server Error'))));
    });
  });

  group('biometricLogin', () {
    const tEmail = 'test@example.com';
    const tPassword = 'testPassword';
    final tUser = MockUser();

    test('should login with email and password when biometric login is successful', () async {
      // Arrange
      when(() => mockAuthLocalSource.readUserEmail)
          .thenAnswer((_) async => tEmail);
      when(() => mockAuthLocalSource.readUserPassword)
          .thenAnswer((_) async => tPassword);
      when(() => mockAuthRemoteSource.loginWithEmailAndPassword(email: tEmail, password: tPassword))
          .thenAnswer((_) async => tUser);
      when(() => mockAuthLocalSource.saveUserEmail(tEmail))
          .thenAnswer((_) async => Future.value());
      when(() => mockAuthLocalSource.saveUserPassword(tPassword))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.biometricLogin();

      // Assert
      verify(() => mockAuthLocalSource.readUserEmail);
      verify(() => mockAuthLocalSource.readUserPassword);
      verify(() => mockAuthRemoteSource.loginWithEmailAndPassword(email: tEmail, password: tPassword));
      expect(result, equals(Right(tUser)));
    });

    test('should return EmptyCacheFailure when there is no email or password saved', () async {
      // Arrange
      when(() => mockAuthLocalSource.readUserEmail)
          .thenAnswer((_) async => null);
      when(() => mockAuthLocalSource.readUserPassword)
          .thenAnswer((_) async => null);

      // Act
      final result = await repository.biometricLogin();

      // Assert
      verify(() => mockAuthLocalSource.readUserEmail);
      verify(() => mockAuthLocalSource.readUserPassword);
      expect(result, equals(const Left(EmptyCacheFailure(message: 'No user found. Try normal login first'))));
    });
  });

  group('saveUserData', () {
    const tEmail = 'test@example.com';
    const tPassword = 'testPassword';

    test('should save user data locally when data is provided', () async {
      // Arrange
      when(() => mockAuthLocalSource.saveUserEmail(tEmail))
          .thenAnswer((_) async => Future.value());
      when(() => mockAuthLocalSource.saveUserPassword(tPassword))
          .thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.saveUserData(tEmail, tPassword);

      // Assert
      verify(() => mockAuthLocalSource.saveUserEmail(tEmail));
      verify(() => mockAuthLocalSource.saveUserPassword(tPassword));
      expect(result, equals(const Right(true)));
    });

    test('should return ServerFailure when email or password is missing', () async {
      // Act
      final result = await repository.saveUserData(null, tPassword);

      // Assert
      expect(result, equals(const Left(ServerFailure(
          message: "Data is missing. Please provide email and password"))));
    });

    test('should return ServerFailure when email or password is empty', () async {
      // Act
      final result = await repository.saveUserData('', tPassword);

      // Assert
      expect(result, equals(const Left(ServerFailure(
          message: "Data is missing. Please provide email and password"))));
    });
  });
}
