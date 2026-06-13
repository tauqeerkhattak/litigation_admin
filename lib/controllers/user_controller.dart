import 'package:litigation_admin/controllers/base_controller.dart';

import '../api/models/user_response.dart';
import '../injection.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class UserState {
  final bool isLoading;
  final List<UserModel> users;
  final String? error;

  UserState({this.isLoading = false, this.users = const [], this.error});

  UserState copyWith({bool? isLoading, List<UserModel>? users, String? error}) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      error: error,
    );
  }
}

class UserController extends BaseController<UserState> {
  UserController() : super(UserState());

  Future<void> fetchUsers() async {
    update(state.copyWith(isLoading: true, error: null));

    try {
      final response = await getIt<UserService>().getUsers();
      update(state.copyWith(isLoading: false, users: response.data));
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    update(state.copyWith(isLoading: true));
    try {
      await getIt<UserService>().createUser(userData);
      await fetchUsers();
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> userData) async {
    update(state.copyWith(isLoading: true));
    try {
      await getIt<UserService>().updateUser(uid, userData);
      await fetchUsers();
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> disableUser(String uid) async {
    try {
      update(state.copyWith(isLoading: true));
      await getIt<UserService>().disableUser(uid);
      await fetchUsers();
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<bool?> forgotPassword(String uid) async {
    return await safeAction(() async {
      update(state.copyWith(isLoading: true, error: null));
      await getIt<AuthService>().forgotPassword(uid);
      update(state.copyWith(isLoading: false));
      return true;
    });
  }

  void update(UserState newState) {
    state = newState;
  }

  @override
  void handleError(String message) {
    update(state.copyWith(isLoading: false, error: message));
    super.handleError(message);
  }
}
