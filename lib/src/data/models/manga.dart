import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/manga_type_enum.dart';
import 'manga_chapter.dart';
import 'manga_writer.dart';
import 'string_pair.dart';

part 'manga.freezed.dart';
part 'manga.g.dart';

@unfreezed
class Manga with _$Manga {
  factory Manga({
    required int id,
    required String name,
    required List<StringPair> alternativeNames,
    required List<String> synonyms,
    required String description,
    required bool isReleasing,
    required MangaTypeEnum type,
    required List<String> tags,
    required List<MangaChapter> chapters,
    required List<String> imagesUrls,
    required MangaWriter writer,
    double? averageScore,
    int? mangaMyAnimeListId,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) = _Manga;

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);
}
