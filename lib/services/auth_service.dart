import '../api/auth_api.dart';
import '../api/models/generic_response.dart';
import '../api/models/login_request.dart';
import '../api/models/login_response.dart';
import 'storage_service.dart';

class AuthService {
  final AuthApi _authApi;
  final StorageService _storage;

  AuthService(this._authApi, this._storage);

  Future<LoginResponse> login(String email, String password) async {
    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _authApi.login(request);

      if (response.status == 'success' || response.status == '200') {
        if (response.token != null) {
          await _storage.setAccessToken(response.token);
        }
      }

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.clearAll();
  }

  Future<bool> loadSession() async {
    final token = await _storage.getAccessToken();
    return token != null;
  }

  Future<GenericResponse> forgotPassword(String uid) async {
    try {
      return await _authApi.forgotPassword(uid);
    } catch (e) {
      rethrow;
    }
  }
}
