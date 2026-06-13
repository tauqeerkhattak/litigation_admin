import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/case_response.dart';

part 'case_api.g.dart';

@RestApi()
abstract class CaseApi {
  factory CaseApi(Dio dio, {String baseUrl}) = _CaseApi;

  @GET("/admin/cases")
  Future<CaseListResponse> getCases();
}
