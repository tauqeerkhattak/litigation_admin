import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable()
class GenericResponse {
  final dynamic data;
  final String message;
  final int status;

  GenericResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenericResponseToJson(this);
}
