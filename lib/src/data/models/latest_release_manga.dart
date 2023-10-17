import 'package:freezed_annotation/freezed_annotation.dart';

import 'chapter_release.dart';
import 'enums/translation_language_enum.dart';
import 'manga_info.dart';

part 'latest_release_manga.freezed.dart';
part 'latest_release_manga.g.dart';

@freezed
class LatestReleaseManga with _$LatestReleaseManga {
  factory LatestReleaseManga({
    required MangaInfo manga,
    required Map<TranslationLanguageEnum, ChapterRelease> releasedChapters,
  }) = _LatestReleaseManga;

  factory LatestReleaseManga.fromJson(Map<String, dynamic> json) =>
      _$LatestReleaseMangaFromJson(json);
}
