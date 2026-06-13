import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserDataResponse {
  final String uid;
  final String email;
  final String name;
  final String countryCode;
  final String phoneNumber;
  final String role;
  final bool disabled;
  final String createdAt;
  final String updatedAt;

  UserDataResponse({
    required this.uid,
    required this.email,
    required this.name,
    required this.countryCode,
    required this.phoneNumber,
    required this.role,
    required this.disabled,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

@JsonSerializable()
class UserListResponse {
  final List<UserDataResponse> data;
  final String message;
  final int status;

  UserListResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);
}

@JsonSerializable()
class UserSingleResponse {
  final UserDataResponse data;
  final String message;
  final int status;

  UserSingleResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory UserSingleResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSingleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserSingleResponseToJson(this);
}
