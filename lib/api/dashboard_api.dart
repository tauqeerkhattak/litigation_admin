import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/dashboard_response.dart';

part 'dashboard_api.g.dart';

@RestApi(
  baseUrl: "https://litigation-backend-74427736097.us-central1.run.app/api/v1/",
)
abstract class DashboardApi {
  factory DashboardApi(Dio dio, {String baseUrl}) = _DashboardApi;

  @GET("dashboard")
  Future<DashboardResponse> getDashboard();
}
