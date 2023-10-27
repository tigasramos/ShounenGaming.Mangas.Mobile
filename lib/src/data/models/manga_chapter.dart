import 'package:freezed_annotation/freezed_annotation.dart';

import 'manga_translation_info.dart';

part 'manga_chapter.freezed.dart';
part 'manga_chapter.g.dart';

@freezed
class MangaChapter with _$MangaChapter {
  factory MangaChapter({
    required int id,
    required num name,
    required List<MangaTranslationInfo> translations,
  }) = _MangaChapter;

  factory MangaChapter.fromJson(Map<String, dynamic> json) =>
      _$MangaChapterFromJson(json);
}
