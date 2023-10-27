// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SimpleUserImpl _$$SimpleUserImplFromJson(Map<String, dynamic> json) =>
    _$SimpleUserImpl(
      id: json['id'] as int,
      fullName: json['fullName'] as String,
      username: json['username'] as String,
      discordImage: json['discordImage'] as String?,
    );

Map<String, dynamic> _$$SimpleUserImplToJson(_$SimpleUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'username': instance.username,
      'discordImage': instance.discordImage,
    };
