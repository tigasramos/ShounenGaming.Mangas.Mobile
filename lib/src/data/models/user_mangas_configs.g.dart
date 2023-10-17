// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mangas_configs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserMangasConfigsImpl _$$UserMangasConfigsImplFromJson(
        Map<String, dynamic> json) =>
    _$UserMangasConfigsImpl(
      readingMode:
          $enumDecode(_$ReadingModeTypeEnumEnumMap, json['readingMode']),
      nsfwBehaviour:
          $enumDecode(_$NSFWBehaviourEnumEnumMap, json['nsfwBehaviour']),
      translationLanguage: $enumDecode(
          _$TranslationLanguageEnumEnumMap, json['translationLanguage']),
      skipChapterToAnotherTranslation:
          json['skipChapterToAnotherTranslation'] as bool,
      showProgressForChaptersWithDecimals:
          json['showProgressForChaptersWithDecimals'] as bool,
    );

Map<String, dynamic> _$$UserMangasConfigsImplToJson(
        _$UserMangasConfigsImpl instance) =>
    <String, dynamic>{
      'readingMode': _$ReadingModeTypeEnumEnumMap[instance.readingMode]!,
      'nsfwBehaviour': _$NSFWBehaviourEnumEnumMap[instance.nsfwBehaviour]!,
      'translationLanguage':
          _$TranslationLanguageEnumEnumMap[instance.translationLanguage]!,
      'skipChapterToAnotherTranslation':
          instance.skipChapterToAnotherTranslation,
      'showProgressForChaptersWithDecimals':
          instance.showProgressForChaptersWithDecimals,
    };

const _$ReadingModeTypeEnumEnumMap = {
  ReadingModeTypeEnum.ALWAYS_VERTICAL: 'ALWAYS_VERTICAL',
  ReadingModeTypeEnum.ALWAYS_VERTICAL_PAGED: 'ALWAYS_VERTICAL_PAGED',
  ReadingModeTypeEnum.ALWAYS_HORIZONTAL: 'ALWAYS_HORIZONTAL',
  ReadingModeTypeEnum.HORIZONTAL_MANGAS_OTHERS_VERTICAL:
      'HORIZONTAL_MANGAS_OTHERS_VERTICAL',
};

const _$NSFWBehaviourEnumEnumMap = {
  NSFWBehaviourEnum.NONE: 'NONE',
  NSFWBehaviourEnum.BLUR_IMAGES: 'BLUR_IMAGES',
  NSFWBehaviourEnum.HIDE_ALL: 'HIDE_ALL',
};

const _$TranslationLanguageEnumEnumMap = {
  TranslationLanguageEnum.PT: 'PT',
  TranslationLanguageEnum.EN: 'EN',
};
