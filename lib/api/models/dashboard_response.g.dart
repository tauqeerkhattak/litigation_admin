// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardData _$DashboardDataFromJson(Map<String, dynamic> json) =>
    DashboardData(
      activeCases: (json['active_cases'] as num).toInt(),
      hearingsToday: (json['hearings_today'] as num).toInt(),
      totalUsers: (json['total_users'] as num).toInt(),
      urgentTasks: (json['urgent_tasks'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardDataToJson(DashboardData instance) =>
    <String, dynamic>{
      'active_cases': instance.activeCases,
      'hearings_today': instance.hearingsToday,
      'total_users': instance.totalUsers,
      'urgent_tasks': instance.urgentTasks,
    };

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      data: DashboardData.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
    };
