import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/manga_type_enum.dart';
import 'enums/translation_language_enum.dart';

part 'manga_translation.freezed.dart';
part 'manga_translation.g.dart';

@freezed
class MangaTranslation with _$MangaTranslation {
  factory MangaTranslation({
    required TranslationLanguageEnum language,
    DateTime? releasedAt,
    required DateTime createdAt,
    required int chapterId,
    required num chapterNumber,
    required String mangaName,
    required MangaTypeEnum mangaType,
    int? previousChapterId,
    int? nextChapterId,
    required String source,
    required List<String> pages,
    required Map<String, String>? pageHeaders,
  }) = _MangaTranslation;

  factory MangaTranslation.fromJson(Map<String, dynamic> json) =>
      _$MangaTranslationFromJson(json);
}
