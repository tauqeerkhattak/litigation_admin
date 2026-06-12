import 'package:json_annotation/json_annotation.dart';

part 'dashboard_response.g.dart';

@JsonSerializable()
class DashboardData {
  @JsonKey(name: 'active_cases')
  final int activeCases;
  @JsonKey(name: 'hearings_today')
  final int hearingsToday;
  @JsonKey(name: 'total_users')
  final int totalUsers;
  @JsonKey(name: 'urgent_tasks')
  final int urgentTasks;

  DashboardData({
    required this.activeCases,
    required this.hearingsToday,
    required this.totalUsers,
    required this.urgentTasks,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardDataToJson(this);
}

@JsonSerializable()
class DashboardResponse {
  final DashboardData data;
  final String message;
  final int status;

  DashboardResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}
