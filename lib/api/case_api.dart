import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/case_response.dart';

part 'case_api.g.dart';

@RestApi(
  baseUrl: "https://litigation-backend-74427736097.us-central1.run.app/api/v1/",
)
abstract class CaseApi {
  factory CaseApi(Dio dio, {String baseUrl}) = _CaseApi;

  @GET("cases")
  Future<CaseListResponse> getCases();
}
