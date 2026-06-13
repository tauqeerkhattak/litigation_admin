import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/user_response.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("/admin/users")
  Future<UserListResponse> getUsers();

  @POST("/admin/users/create")
  Future<UserSingleResponse> createUser(@Body() Map<String, dynamic> request);

  @DELETE("/admin/users/{uid}")
  Future<UserSingleResponse> disableUser(@Path("uid") String uid);
}
