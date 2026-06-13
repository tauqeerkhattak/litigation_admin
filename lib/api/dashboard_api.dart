import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/dashboard_response.dart';

part 'dashboard_api.g.dart';

@RestApi()
abstract class DashboardApi {
  factory DashboardApi(Dio dio, {String baseUrl}) = _DashboardApi;

  @GET("/admin/dashboard")
  Future<DashboardResponse> getDashboard();
}
