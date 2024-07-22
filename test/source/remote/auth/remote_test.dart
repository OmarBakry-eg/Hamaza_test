import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_test/src/core/errors/exceptions.dart';
import 'package:news_app_test/src/feature/login/data/source/remote/remote_source.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

void main() {
  late AuthRemoteSource dataSource;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUser mockUser;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = AuthRemoteSource(firebaseAuth: mockFirebaseAuth);
    mockUser = MockUser();
  });

  group('loginWithEmailAndPassword', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password';
    final tUserCredential = MockUserCredential();
    final tUser = MockUser();

    test('should return User when the call to FirebaseAuth is successful', () async {
      // Arrange
      when(() => tUserCredential.user).thenReturn(tUser);
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenAnswer((_) async => tUserCredential);

      // Act
      final result = await dataSource.loginWithEmailAndPassword(email: tEmail, password: tPassword);

      // Assert
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(email: tEmail, password: tPassword));
      expect(result, equals(tUser));
    });

    test('should throw a ServerException when the call to FirebaseAuth is unsuccessful', () async {
      // Arrange
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          )).thenThrow(FirebaseAuthException(message: 'Error', code: 'ERROR'));

      // Act
      final call = dataSource.loginWithEmailAndPassword;

      // Assert
      expect(() => call(email: tEmail, password: tPassword), throwsA(isA<ServerException>()));
    });
  });

  group('deleteAccount', () {
    test('should return true when the user is deleted successfully', () async {
      // Arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.delete()).thenAnswer((_) async => Future.value());

      // Act
      final result = await dataSource.deleteAccount();

      // Assert
      verify(() => mockFirebaseAuth.currentUser);
      verify(() => mockUser.delete());
      expect(result, equals(true));
    });

    test('should throw an EmptyCacheException when there is no current user', () async {
      // Arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      // Act
      final call = dataSource.deleteAccount;

      // Assert
      expect(() => call(), throwsA(isA<EmptyCacheException>()));
    });

    test('should throw a ServerException when the call to FirebaseAuth is unsuccessful', () async {
      // Arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.delete()).thenThrow(FirebaseAuthException(message: 'Error', code: 'ERROR'));

      // Act
      final call = dataSource.deleteAccount;

      // Assert
      expect(() => call(), throwsA(isA<ServerException>()));
    });
  });
}
