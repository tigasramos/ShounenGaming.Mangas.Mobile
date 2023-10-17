// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_translation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaTranslationImpl _$$MangaTranslationImplFromJson(
        Map<String, dynamic> json) =>
    _$MangaTranslationImpl(
      language: $enumDecode(_$TranslationLanguageEnumEnumMap, json['language']),
      releasedAt: json['releasedAt'] == null
          ? null
          : DateTime.parse(json['releasedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      chapterId: json['chapterId'] as int,
      chapterNumber: json['chapterNumber'] as num,
      mangaName: json['mangaName'] as String,
      mangaType: $enumDecode(_$MangaTypeEnumEnumMap, json['mangaType']),
      previousChapterId: json['previousChapterId'] as int?,
      nextChapterId: json['nextChapterId'] as int?,
      source: json['source'] as String,
      pages: (json['pages'] as List<dynamic>).map((e) => e as String).toList(),
      pageHeaders: (json['pageHeaders'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$MangaTranslationImplToJson(
        _$MangaTranslationImpl instance) =>
    <String, dynamic>{
      'language': _$TranslationLanguageEnumEnumMap[instance.language]!,
      'releasedAt': instance.releasedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'chapterId': instance.chapterId,
      'chapterNumber': instance.chapterNumber,
      'mangaName': instance.mangaName,
      'mangaType': _$MangaTypeEnumEnumMap[instance.mangaType]!,
      'previousChapterId': instance.previousChapterId,
      'nextChapterId': instance.nextChapterId,
      'source': instance.source,
      'pages': instance.pages,
      'pageHeaders': instance.pageHeaders,
    };

const _$TranslationLanguageEnumEnumMap = {
  TranslationLanguageEnum.PT: 'PT',
  TranslationLanguageEnum.EN: 'EN',
};

const _$MangaTypeEnumEnumMap = {
  MangaTypeEnum.MANGA: 'MANGA',
  MangaTypeEnum.MANWHA: 'MANWHA',
  MangaTypeEnum.MANHUA: 'MANHUA',
};
