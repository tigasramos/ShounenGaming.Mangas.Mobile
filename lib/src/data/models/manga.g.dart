// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaImpl _$$MangaImplFromJson(Map<String, dynamic> json) => _$MangaImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      alternativeNames: (json['alternativeNames'] as List<dynamic>)
          .map((e) => StringPair.fromJson(e as Map<String, dynamic>))
          .toList(),
      synonyms:
          (json['synonyms'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      isReleasing: json['isReleasing'] as bool,
      type: $enumDecode(_$MangaTypeEnumEnumMap, json['type']),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => MangaChapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      imagesUrls: (json['imagesUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      writer: MangaWriter.fromJson(json['writer'] as Map<String, dynamic>),
      averageScore: (json['averageScore'] as num?)?.toDouble(),
      mangaMyAnimeListId: json['mangaMyAnimeListId'] as int?,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      finishedAt: json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
    );

Map<String, dynamic> _$$MangaImplToJson(_$MangaImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'alternativeNames': instance.alternativeNames,
      'synonyms': instance.synonyms,
      'description': instance.description,
      'isReleasing': instance.isReleasing,
      'type': _$MangaTypeEnumEnumMap[instance.type]!,
      'tags': instance.tags,
      'chapters': instance.chapters,
      'imagesUrls': instance.imagesUrls,
      'writer': instance.writer,
      'averageScore': instance.averageScore,
      'mangaMyAnimeListId': instance.mangaMyAnimeListId,
      'startedAt': instance.startedAt?.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
    };

const _$MangaTypeEnumEnumMap = {
  MangaTypeEnum.MANGA: 'MANGA',
  MangaTypeEnum.MANWHA: 'MANWHA',
  MangaTypeEnum.MANHUA: 'MANHUA',
};
