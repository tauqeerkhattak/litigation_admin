import 'package:control_room/control_room.dart';

import '../api/models/case_response.dart';
import '../services/case_service.dart';

class CaseState {
  final bool isLoading;
  final List<CaseDataResponse> cases;
  final String? error;

  CaseState({this.isLoading = false, this.cases = const [], this.error});

  CaseState copyWith({
    bool? isLoading,
    List<CaseDataResponse>? cases,
    String? error,
  }) {
    return CaseState(
      isLoading: isLoading ?? this.isLoading,
      cases: cases ?? this.cases,
      error: error,
    );
  }
}

class CaseController extends StateController<CaseState> {
  final CaseService _caseService;

  CaseController(this._caseService) : super(CaseState());

  Future<void> fetchCases() async {
    update(state.copyWith(isLoading: true, error: null));

    try {
      final response = await _caseService.getCases();
      update(state.copyWith(isLoading: false, cases: response.data));
    } catch (e) {
      update(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void update(CaseState newState) {
    state = newState;
  }
}
