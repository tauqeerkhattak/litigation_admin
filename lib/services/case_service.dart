import '../api/case_api.dart';
import '../api/models/case_response.dart';

class CaseService {
  final CaseApi _caseApi;

  CaseService(this._caseApi);

  Future<CaseListResponse> getCases() async {
    try {
      return await _caseApi.getCases();
    } catch (e) {
      rethrow;
    }
  }
}
