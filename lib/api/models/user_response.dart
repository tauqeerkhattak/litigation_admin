import 'package:json_annotation/json_annotation.dart';
import 'package:litigation_admin/utils/constants.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String countryCode;
  final String phoneNumber;
  final UserRole role;
  final bool disabled;
  final String createdAt;
  final String updatedAt;

  UserModel({
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

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserListResponse {
  final List<UserModel> data;
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
  final UserModel data;
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
