import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/generic_response.dart';
import 'models/login_request.dart';
import 'models/login_response.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("admin/login")
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST("/admin/users/{uid}/forgot-password")
  Future<GenericResponse> forgotPassword(@Path("uid") String uid);
}
