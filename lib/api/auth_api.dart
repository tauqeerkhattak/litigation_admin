import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/login_request.dart';
import 'models/login_response.dart';
import 'models/generic_response.dart';

part 'auth_api.g.dart';

@RestApi(
  baseUrl: "https://litigation-backend-74427736097.us-central1.run.app/api/v1/",
)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("admin/login")
  Future<LoginResponse> login(@Body() LoginRequest request);

  @POST("users/{uid}/forgot-password")
  Future<GenericResponse> forgotPassword(@Path("uid") String uid);
}
