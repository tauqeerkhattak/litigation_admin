import '../api/auth_api.dart';
import '../api/models/login_request.dart';
import '../api/models/login_response.dart';

class AuthService {
  final AuthApi _authApi;

  AuthService(this._authApi);

  Future<LoginResponse> login(String email, String password) async {
    try {
      final request = LoginRequest(email: email, password: password);
      return await _authApi.login(request);
    } catch (e) {
      rethrow;
    }
  }
}
