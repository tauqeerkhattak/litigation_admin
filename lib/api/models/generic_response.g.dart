// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericResponse _$GenericResponseFromJson(Map<String, dynamic> json) =>
    GenericResponse(
      data: json['data'],
      message: json['message'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$GenericResponseToJson(GenericResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
    };
