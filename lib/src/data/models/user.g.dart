// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      discordId: json['discordId'] as String,
      discordImage: json['discordImage'] as String,
      username: json['username'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      role: $enumDecode(_$RolesEnumEnumMap, json['role']),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'discordId': instance.discordId,
      'discordImage': instance.discordImage,
      'username': instance.username,
      'birthday': instance.birthday.toIso8601String(),
      'role': _$RolesEnumEnumMap[instance.role]!,
    };

const _$RolesEnumEnumMap = {
  RolesEnum.ADMIN: 'ADMIN',
  RolesEnum.MOD: 'MOD',
  RolesEnum.USER: 'USER',
};
