// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_user_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaUserActivityImpl _$$MangaUserActivityImplFromJson(
        Map<String, dynamic> json) =>
    _$MangaUserActivityImpl(
      user: SimpleUser.fromJson(json['user'] as Map<String, dynamic>),
      manga: MangaInfo.fromJson(json['manga'] as Map<String, dynamic>),
      madeAt: DateTime.parse(json['madeAt'] as String),
      activityType:
          $enumDecode(_$UserActivityTypeEnumEnumMap, json['activityType']),
      firstChapterRead: (json['firstChapterRead'] as num?)?.toDouble(),
      lastChapterRead: (json['lastChapterRead'] as num?)?.toDouble(),
      previousState: $enumDecodeNullable(
          _$MangaUserStatusEnumEnumMap, json['previousState']),
      newState:
          $enumDecodeNullable(_$MangaUserStatusEnumEnumMap, json['newState']),
    );

Map<String, dynamic> _$$MangaUserActivityImplToJson(
        _$MangaUserActivityImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'manga': instance.manga,
      'madeAt': instance.madeAt.toIso8601String(),
      'activityType': _$UserActivityTypeEnumEnumMap[instance.activityType]!,
      'firstChapterRead': instance.firstChapterRead,
      'lastChapterRead': instance.lastChapterRead,
      'previousState': _$MangaUserStatusEnumEnumMap[instance.previousState],
      'newState': _$MangaUserStatusEnumEnumMap[instance.newState],
    };

const _$UserActivityTypeEnumEnumMap = {
  UserActivityTypeEnum.SEE_CHAPTER: 'SEE_CHAPTER',
  UserActivityTypeEnum.UNSEE_CHAPTER: 'UNSEE_CHAPTER',
  UserActivityTypeEnum.ADD_MANGA: 'ADD_MANGA',
  UserActivityTypeEnum.CHANGE_STATUS: 'CHANGE_STATUS',
};

const _$MangaUserStatusEnumEnumMap = {
  MangaUserStatusEnum.READING: 'READING',
  MangaUserStatusEnum.ON_HOLD: 'ON_HOLD',
  MangaUserStatusEnum.COMPLETED: 'COMPLETED',
  MangaUserStatusEnum.PLANNED: 'PLANNED',
  MangaUserStatusEnum.DROPPED: 'DROPPED',
  MangaUserStatusEnum.IGNORED: 'IGNORED',
};
