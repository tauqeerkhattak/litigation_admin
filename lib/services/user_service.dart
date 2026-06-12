import '../api/user_api.dart';
import '../api/models/user_response.dart';

class UserService {
  final UserApi _userApi;

  UserService(this._userApi);

  Future<UserListResponse> getUsers() async {
    try {
      return await _userApi.getUsers();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserSingleResponse> createUser(Map<String, dynamic> userData) async {
    try {
      return await _userApi.createUser(userData);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserSingleResponse> disableUser(String uid) async {
    try {
      return await _userApi.disableUser(uid);
    } catch (e) {
      rethrow;
    }
  }
}
