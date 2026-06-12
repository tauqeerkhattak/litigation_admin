import '../api/dashboard_api.dart';
import '../api/models/dashboard_response.dart';

class DashboardService {
  final DashboardApi _dashboardApi;

  DashboardService(this._dashboardApi);

  Future<DashboardResponse> getDashboard() async {
    try {
      return await _dashboardApi.getDashboard();
    } catch (e) {
      rethrow;
    }
  }
}
