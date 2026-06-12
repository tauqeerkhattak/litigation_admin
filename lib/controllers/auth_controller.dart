import 'package:control_room/control_room.dart';

import '../api/models/login_response.dart';
import '../services/auth_service.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final bool isLoggedIn;

  AuthState({this.isLoading = false, this.error, this.isLoggedIn = false});

  AuthState copyWith({bool? isLoading, String? error, bool? isLoggedIn}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class AuthController extends StateController<AuthState> {
  final AuthService _authService;

  AuthController(this._authService) : super(AuthState());

  Future<LoginResponse?> login(String email, String password) async {
    update(state.copyWith(isLoading: true, error: null));

    try {
      final response = await _authService.login(email, password);

      if (response.status == 'success' || response.status == '200') {
        update(state.copyWith(isLoading: false, isLoggedIn: true));
      } else {
        update(state.copyWith(isLoading: false, error: response.message));
      }
      return response;
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
      return null;
    }
  }

  void update(AuthState newState) {
    state = newState;
  }

  Future<void> logout() async {
    await _authService.logout();
    update(AuthState());
  }

  Future<void> forgotPassword(String uid) async {
    update(state.copyWith(isLoading: true, error: null));

    try {
      await _authService.forgotPassword(uid);
      update(state.copyWith(isLoading: false));
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
      rethrow;
    }
  }
}
