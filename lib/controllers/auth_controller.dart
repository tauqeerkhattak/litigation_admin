import '../injection.dart';
import '../services/auth_service.dart';
import 'base_controller.dart';

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

class AuthController extends BaseController<AuthState> {
  AuthController() : super(AuthState());

  Future<bool?> login(String email, String password) async {
    return await safeAction(() async {
      update(state.copyWith(isLoading: true, error: null));
      final response = await getIt<AuthService>().login(email, password);
      final success = response.status == 200;
      update(state.copyWith(isLoading: false, isLoggedIn: success));
      return success;
    });
  }

  void update(AuthState newState) {
    state = newState;
  }

  Future<void> logout() async {
    await getIt<AuthService>().logout();
    update(AuthState());
  }

  @override
  void handleError(String message) {
    update(state.copyWith(isLoading: false, error: message));
    super.handleError(message);
  }
}
