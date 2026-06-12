import 'package:control_room/control_room.dart';

import '../api/models/dashboard_response.dart';
import '../services/dashboard_service.dart';

class DashboardState {
  final bool isLoading;
  final DashboardData? data;
  final String? error;

  DashboardState({this.isLoading = false, this.data, this.error});

  DashboardState copyWith({
    bool? isLoading,
    DashboardData? data,
    String? error,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }
}

class DashboardController extends StateController<DashboardState> {
  final DashboardService _dashboardService;

  DashboardController(this._dashboardService) : super(DashboardState());

  Future<void> fetchDashboardData() async {
    update(state.copyWith(isLoading: true, error: null));

    try {
      final response = await _dashboardService.getDashboard();
      update(state.copyWith(isLoading: false, data: response.data));
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void update(DashboardState newState) {
    state = newState;
  }
}
