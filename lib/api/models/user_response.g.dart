// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  uid: json['uid'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  countryCode: json['country_code'] as String,
  phoneNumber: json['phone_number'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  disabled: json['disabled'] as bool,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'name': instance.name,
  'country_code': instance.countryCode,
  'phone_number': instance.phoneNumber,
  'role': _$UserRoleEnumMap[instance.role]!,
  'disabled': instance.disabled,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

const _$UserRoleEnumMap = {
  UserRole.editor: 'editor',
  UserRole.commentor: 'commentor',
  UserRole.documentor: 'documentor',
  UserRole.viewer: 'viewer',
};

UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) =>
    UserListResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$UserListResponseToJson(UserListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
    };

UserSingleResponse _$UserSingleResponseFromJson(Map<String, dynamic> json) =>
    UserSingleResponse(
      data: UserModel.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$UserSingleResponseToJson(UserSingleResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'status': instance.status,
    };
