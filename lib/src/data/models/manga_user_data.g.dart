// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaUserDataImpl _$$MangaUserDataImplFromJson(Map<String, dynamic> json) =>
    _$MangaUserDataImpl(
      userId: json['userId'] as int,
      manga: MangaInfo.fromJson(json['manga'] as Map<String, dynamic>),
      status: $enumDecodeNullable(_$MangaUserStatusEnumEnumMap, json['status']),
      rating: (json['rating'] as num?)?.toDouble(),
      filteredReadChapters: json['filteredReadChapters'] as int,
      filteredTotalChapters: json['filteredTotalChapters'] as int,
      addedToStatusDate: json['addedToStatusDate'] == null
          ? null
          : DateTime.parse(json['addedToStatusDate'] as String),
      startedReadingDate: json['startedReadingDate'] == null
          ? null
          : DateTime.parse(json['startedReadingDate'] as String),
      finishedReadingDate: json['finishedReadingDate'] == null
          ? null
          : DateTime.parse(json['finishedReadingDate'] as String),
      chaptersRead:
          (json['chaptersRead'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$MangaUserDataImplToJson(_$MangaUserDataImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'manga': instance.manga,
      'status': _$MangaUserStatusEnumEnumMap[instance.status],
      'rating': instance.rating,
      'filteredReadChapters': instance.filteredReadChapters,
      'filteredTotalChapters': instance.filteredTotalChapters,
      'addedToStatusDate': instance.addedToStatusDate?.toIso8601String(),
      'startedReadingDate': instance.startedReadingDate?.toIso8601String(),
      'finishedReadingDate': instance.finishedReadingDate?.toIso8601String(),
      'chaptersRead': instance.chaptersRead,
    };

const _$MangaUserStatusEnumEnumMap = {
  MangaUserStatusEnum.READING: 'READING',
  MangaUserStatusEnum.ON_HOLD: 'ON_HOLD',
  MangaUserStatusEnum.COMPLETED: 'COMPLETED',
  MangaUserStatusEnum.PLANNED: 'PLANNED',
  MangaUserStatusEnum.DROPPED: 'DROPPED',
  MangaUserStatusEnum.IGNORED: 'IGNORED',
};
