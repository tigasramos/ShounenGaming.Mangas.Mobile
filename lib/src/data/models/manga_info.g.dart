// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaInfoImpl _$$MangaInfoImplFromJson(Map<String, dynamic> json) =>
    _$MangaInfoImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      isReleasing: json['isReleasing'] as bool,
      isNSFW: json['isNSFW'] as bool,
      type: $enumDecode(_$MangaTypeEnumEnumMap, json['type']),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      chaptersCount: json['chaptersCount'] as int,
      imagesUrls: (json['imagesUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      myAnimeListId: json['myAnimeListId'] as int?,
      anilistId: json['anilistId'] as int?,
      averageScore: (json['averageScore'] as num?)?.toDouble(),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
      lastChapterDate: json['lastChapterDate'] == null
          ? null
          : DateTime.parse(json['lastChapterDate'] as String),
    );

Map<String, dynamic> _$$MangaInfoImplToJson(_$MangaInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isReleasing': instance.isReleasing,
      'isNSFW': instance.isNSFW,
      'type': _$MangaTypeEnumEnumMap[instance.type]!,
      'tags': instance.tags,
      'chaptersCount': instance.chaptersCount,
      'imagesUrls': instance.imagesUrls,
      'myAnimeListId': instance.myAnimeListId,
      'anilistId': instance.anilistId,
      'averageScore': instance.averageScore,
      'startedAt': instance.startedAt?.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'lastChapterDate': instance.lastChapterDate?.toIso8601String(),
    };

const _$MangaTypeEnumEnumMap = {
  MangaTypeEnum.MANGA: 'MANGA',
  MangaTypeEnum.MANWHA: 'MANWHA',
  MangaTypeEnum.MANHUA: 'MANHUA',
};
