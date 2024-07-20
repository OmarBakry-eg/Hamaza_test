import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// {@template token_storage}
/// Token storage for the authentication client.
/// {@endtemplate}
abstract class TokenStorage {
  /// Returns the current token.
  Future<String?> get readToken;

  /// Saves the current token.
  Future<void> saveToken(String token);

  /// Clears the current token.
  Future<void> clearToken();
}


class InMemoryTokenStorage implements TokenStorage {
  final FlutterSecureStorage secureStorage;
  const InMemoryTokenStorage({required this.secureStorage});

  final String _key = 'token';

  @override
  Future<String?> get readToken async => await secureStorage.read(key: _key);

  @override
  Future<void> saveToken(String token) async =>
      await secureStorage.write(key: _key, value: token);

  @override
  Future<void> clearToken() async => await secureStorage.delete(key: _key);
}
