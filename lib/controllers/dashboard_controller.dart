import 'package:control_room/control_room.dart';

import '../api/models/dashboard_response.dart';
import '../injection.dart';
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
  DashboardController() : super(DashboardState());

  Future<void> fetchDashboardData() async {
    update(state.copyWith(isLoading: true, error: null));

    try {
      final response = await getIt<DashboardService>().getDashboard();
      update(state.copyWith(isLoading: false, data: response.data));
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void update(DashboardState newState) {
    state = newState;
  }
}
