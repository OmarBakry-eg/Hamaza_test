import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_app_test/src/feature/login/data/source/local/local_source.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late AuthLocalSource dataSource;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    dataSource = AuthLocalSource(secureStorage: mockSecureStorage);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password';

  setUpAll(() {
    registerFallbackValue(const Duration());
  });

  group('readUserEmail', () {
    test('should return the saved email from secure storage', () async {
      // Arrange
      when(() => mockSecureStorage.read(key: 'email'))
          .thenAnswer((_) async => tEmail);

      // Act
      final result = await dataSource.readUserEmail;

      // Assert
      verify(() => mockSecureStorage.read(key: 'email'));
      expect(result, equals(tEmail));
    });
  });

  group('saveUserEmail', () {
    test('should save the email to secure storage', () async {
      // Arrange
      when(() => mockSecureStorage.write(key: 'email', value: tEmail))
          .thenAnswer((_) async => Future.value());

      // Act
      await dataSource.saveUserEmail(tEmail);

      // Assert
      verify(() => mockSecureStorage.write(key: 'email', value: tEmail));
    });
  });

  group('readUserPassword', () {
    test('should return the saved password from secure storage', () async {
      // Arrange
      when(() => mockSecureStorage.read(key: 'password'))
          .thenAnswer((_) async => tPassword);

      // Act
      final result = await dataSource.readUserPassword;

      // Assert
      verify(() => mockSecureStorage.read(key: 'password'));
      expect(result, equals(tPassword));
    });
  });

  group('saveUserPassword', () {
    test('should save the password to secure storage', () async {
      // Arrange
      when(() => mockSecureStorage.write(key: 'password', value: tPassword))
          .thenAnswer((_) async => Future.value());

      // Act
      await dataSource.saveUserPassword(tPassword);

      // Assert
      verify(() => mockSecureStorage.write(key: 'password', value: tPassword));
    });
  });

  group('clearUserData', () {
    test('should clear the email and password from secure storage', () async {
      // Arrange
      when(() => mockSecureStorage.delete(key: 'email'))
          .thenAnswer((_) async => Future.value());
      when(() => mockSecureStorage.delete(key: 'password'))
          .thenAnswer((_) async => Future.value());

      // Act
      await dataSource.clearUserData();

      // Assert
      verify(() => mockSecureStorage.delete(key: 'email'));
      verify(() => mockSecureStorage.delete(key: 'password'));
    });
  });
}
