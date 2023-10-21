// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_chapter_read_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserChapterReadHistoryImpl _$$UserChapterReadHistoryImplFromJson(
        Map<String, dynamic> json) =>
    _$UserChapterReadHistoryImpl(
      readAt: DateTime.parse(json['readAt'] as String),
      numOfFirstChapter: json['numOfFirstChapter'] as num,
      numOfLastChapter: json['numOfLastChapter'] as num?,
      manga: MangaInfo.fromJson(json['manga'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserChapterReadHistoryImplToJson(
        _$UserChapterReadHistoryImpl instance) =>
    <String, dynamic>{
      'readAt': instance.readAt.toIso8601String(),
      'numOfFirstChapter': instance.numOfFirstChapter,
      'numOfLastChapter': instance.numOfLastChapter,
      'manga': instance.manga,
    };
