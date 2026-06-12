import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/user_response.dart';

part 'user_api.g.dart';

@RestApi(
  baseUrl: "https://litigation-backend-74427736097.us-central1.run.app/api/v1/",
)
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("users")
  Future<UserListResponse> getUsers();

  @POST("users/create")
  Future<UserSingleResponse> createUser(@Body() Map<String, dynamic> request);

  @DELETE("users/{uid}")
  Future<UserSingleResponse> disableUser(@Path("uid") String uid);
}
