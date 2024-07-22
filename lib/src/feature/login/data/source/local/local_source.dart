import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// {@template token_storage}
/// Token storage for the authentication client.
/// {@endtemplate}
abstract class AuthStorage {
  /// Returns the current email.
  Future<String?> get readUserEmail;

  /// Saves the current token.
  Future<void> saveUserEmail(String email);

  /// Returns the current password.
  Future<String?> get readUserPassword;

  /// Saves the current token.
  Future<void> saveUserPassword(String password);

  /// Clears the current token.
  Future<void> clearUserData();
}

class AuthLocalSource implements AuthStorage {
  final FlutterSecureStorage secureStorage;
  const AuthLocalSource({required this.secureStorage});

  final String _keyEmail = 'email';
  final String _keyPassword = 'password';

  @override
  Future<void> clearUserData() async {
    await secureStorage.delete(key: _keyEmail);
    await secureStorage.delete(key: _keyPassword);
  }

  @override
  Future<String?> get readUserEmail async =>
      await secureStorage.read(key: _keyEmail);

  @override
  Future<String?> get readUserPassword async =>
      await secureStorage.read(key: _keyPassword);

  @override
  Future<void> saveUserEmail(String email) async =>
      await secureStorage.write(key: _keyEmail, value: email);

  @override
  Future<void> saveUserPassword(String password) async =>
      await secureStorage.write(key: _keyPassword, value: password);
}
