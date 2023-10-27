// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChapterReleaseImpl _$$ChapterReleaseImplFromJson(Map<String, dynamic> json) =>
    _$ChapterReleaseImpl(
      id: json['id'] as int,
      name: json['name'] as num,
      createdAt: DateTime.parse(json['createdAt'] as String),
      translation:
          $enumDecode(_$TranslationLanguageEnumEnumMap, json['translation']),
    );

Map<String, dynamic> _$$ChapterReleaseImplToJson(
        _$ChapterReleaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
      'translation': _$TranslationLanguageEnumEnumMap[instance.translation]!,
    };

const _$TranslationLanguageEnumEnumMap = {
  TranslationLanguageEnum.PT: 'PT',
  TranslationLanguageEnum.EN: 'EN',
};
