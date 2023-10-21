// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_manga_main_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMangaMainStatsImpl _$$UserMangaMainStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$UserMangaMainStatsImpl(
      numOfMangas: json['numOfMangas'] as int,
      numOfChapters: json['numOfChapters'] as int,
      averageScore: json['averageScore'] as num,
      mangaTypeCounters:
          (json['mangaTypeCounters'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$MangaTypeEnumEnumMap, k), e as int),
      ),
      mangaUserStatusCounters:
          (json['mangaUserStatusCounters'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry($enumDecode(_$MangaUserStatusEnumEnumMap, k), e as int),
      ),
      dailyActivityCounters:
          (json['dailyActivityCounters'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(DateTime.parse(k), e as int),
      ),
      mangaTagsCounters:
          Map<String, int>.from(json['mangaTagsCounters'] as Map),
    );

Map<String, dynamic> _$$UserMangaMainStatsImplToJson(
        _$UserMangaMainStatsImpl instance) =>
    <String, dynamic>{
      'numOfMangas': instance.numOfMangas,
      'numOfChapters': instance.numOfChapters,
      'averageScore': instance.averageScore,
      'mangaTypeCounters': instance.mangaTypeCounters
          .map((k, e) => MapEntry(_$MangaTypeEnumEnumMap[k]!, e)),
      'mangaUserStatusCounters': instance.mangaUserStatusCounters
          .map((k, e) => MapEntry(_$MangaUserStatusEnumEnumMap[k]!, e)),
      'dailyActivityCounters': instance.dailyActivityCounters
          .map((k, e) => MapEntry(k.toIso8601String(), e)),
      'mangaTagsCounters': instance.mangaTagsCounters,
    };

const _$MangaTypeEnumEnumMap = {
  MangaTypeEnum.MANGA: 'MANGA',
  MangaTypeEnum.MANWHA: 'MANWHA',
  MangaTypeEnum.MANHUA: 'MANHUA',
};

const _$MangaUserStatusEnumEnumMap = {
  MangaUserStatusEnum.READING: 'READING',
  MangaUserStatusEnum.ON_HOLD: 'ON_HOLD',
  MangaUserStatusEnum.COMPLETED: 'COMPLETED',
  MangaUserStatusEnum.PLANNED: 'PLANNED',
  MangaUserStatusEnum.DROPPED: 'DROPPED',
  MangaUserStatusEnum.IGNORED: 'IGNORED',
};
