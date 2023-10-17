// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaChapterImpl _$$MangaChapterImplFromJson(Map<String, dynamic> json) =>
    _$MangaChapterImpl(
      id: json['id'] as int,
      name: json['name'] as num,
      translations: (json['translations'] as List<dynamic>)
          .map((e) => MangaTranslationInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MangaChapterImplToJson(_$MangaChapterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'translations': instance.translations,
    };
