// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_translation_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaTranslationInfoImpl _$$MangaTranslationInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$MangaTranslationInfoImpl(
      id: json['id'] as int,
      language: $enumDecode(_$TranslationLanguageEnumEnumMap, json['language']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MangaTranslationInfoImplToJson(
        _$MangaTranslationInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': _$TranslationLanguageEnumEnumMap[instance.language]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$TranslationLanguageEnumEnumMap = {
  TranslationLanguageEnum.PT: 'PT',
  TranslationLanguageEnum.EN: 'EN',
};
