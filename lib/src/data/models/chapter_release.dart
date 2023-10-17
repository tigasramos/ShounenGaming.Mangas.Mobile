import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/translation_language_enum.dart';

part 'chapter_release.freezed.dart';
part 'chapter_release.g.dart';

@freezed
class ChapterRelease with _$ChapterRelease {
  factory ChapterRelease({
    required int id,
    required num name,
    required DateTime createdAt,
    required TranslationLanguageEnum translation,
  }) = _ChapterRelease;

  factory ChapterRelease.fromJson(Map<String, dynamic> json) =>
      _$ChapterReleaseFromJson(json);
}
