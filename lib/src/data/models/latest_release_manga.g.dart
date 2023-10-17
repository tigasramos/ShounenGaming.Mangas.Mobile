// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_release_manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LatestReleaseMangaImpl _$$LatestReleaseMangaImplFromJson(
        Map<String, dynamic> json) =>
    _$LatestReleaseMangaImpl(
      manga: MangaInfo.fromJson(json['manga'] as Map<String, dynamic>),
      releasedChapters: (json['releasedChapters'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$TranslationLanguageEnumEnumMap, k),
            ChapterRelease.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$LatestReleaseMangaImplToJson(
        _$LatestReleaseMangaImpl instance) =>
    <String, dynamic>{
      'manga': instance.manga,
      'releasedChapters': instance.releasedChapters
          .map((k, e) => MapEntry(_$TranslationLanguageEnumEnumMap[k]!, e)),
    };

const _$TranslationLanguageEnumEnumMap = {
  TranslationLanguageEnum.PT: 'PT',
  TranslationLanguageEnum.EN: 'EN',
};
