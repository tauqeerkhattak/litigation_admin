import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage _storage;

  StorageService(this._storage);

  static const String _tokenKey = 'access_token';

  /// Retrieves the stored access token.
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Saves or deletes the access token.
  Future<void> setAccessToken(String? token) async {
    if (token == null) {
      await _storage.delete(key: _tokenKey);
    } else {
      await _storage.write(key: _tokenKey, value: token);
    }
  }

  /// Clears all stored data (e.g., on logout).
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
