import 'package:control_room/control_room.dart';

import '../api/models/user_response.dart';
import '../injection.dart';
import '../services/user_service.dart';

class UserState {
  final bool isLoading;
  final List<UserDataResponse> users;
  final String? error;

  UserState({this.isLoading = false, this.users = const [], this.error});

  UserState copyWith({
    bool? isLoading,
    List<UserDataResponse>? users,
    String? error,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      error: error,
    );
  }
}

class UserController extends StateController<UserState> {
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

  Future<void> disableUser(String uid) async {
    update(state.copyWith(isLoading: true));
    try {
      await getIt<UserService>().disableUser(uid);
      await fetchUsers();
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void update(UserState newState) {
    state = newState;
  }
}
