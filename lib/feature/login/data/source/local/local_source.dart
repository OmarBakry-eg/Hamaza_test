import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// {@template token_storage}
/// Token storage for the authentication client.
/// {@endtemplate}
abstract class AuthStorage {
  /// Returns the current token.
  Future<String?> get readUserData;

  /// Saves the current token.
  Future<void> saveUserData(String userData);

  /// Clears the current token.
  Future<void> clearUserData();
}

class AuthLocalSource implements AuthStorage {
  final FlutterSecureStorage secureStorage;
  const AuthLocalSource({required this.secureStorage});

  final String _key = 'token';

  @override
  Future<String?> get readUserData async => await secureStorage.read(key: _key);

  @override
  Future<void> saveUserData(String userData) async =>
      await secureStorage.write(key: _key, value: userData);

  @override
  Future<void> clearUserData() async => await secureStorage.delete(key: _key);
}
