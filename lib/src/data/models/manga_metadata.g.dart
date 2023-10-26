// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaMetadataImpl _$$MangaMetadataImplFromJson(Map<String, dynamic> json) =>
    _$MangaMetadataImpl(
      id: json['id'] as int,
      source: $enumDecode(_$MangaMetadataSourceEnumEnumMap, json['source']),
      titles:
          (json['titles'] as List<dynamic>).map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String,
      alreadyExists: json['alreadyExists'] as bool,
      type: $enumDecode(_$MangaTypeEnumEnumMap, json['type']),
      description: json['description'] as String,
      status: json['status'] as String,
      score: json['score'] as num?,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
    );

Map<String, dynamic> _$$MangaMetadataImplToJson(_$MangaMetadataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source': _$MangaMetadataSourceEnumEnumMap[instance.source]!,
      'titles': instance.titles,
      'imageUrl': instance.imageUrl,
      'alreadyExists': instance.alreadyExists,
      'type': _$MangaTypeEnumEnumMap[instance.type]!,
      'description': instance.description,
      'status': instance.status,
      'score': instance.score,
      'tags': instance.tags,
      'startedAt': instance.startedAt?.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
    };

const _$MangaMetadataSourceEnumEnumMap = {
  MangaMetadataSourceEnum.MYANIMELIST: 'MYANIMELIST',
  MangaMetadataSourceEnum.ANILIST: 'ANILIST',
};

const _$MangaTypeEnumEnumMap = {
  MangaTypeEnum.MANGA: 'MANGA',
  MangaTypeEnum.MANWHA: 'MANWHA',
  MangaTypeEnum.MANHUA: 'MANHUA',
};
