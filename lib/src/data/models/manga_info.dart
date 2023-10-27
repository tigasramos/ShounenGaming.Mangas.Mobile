import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/manga_type_enum.dart';

part 'manga_info.freezed.dart';
part 'manga_info.g.dart';

@freezed
class MangaInfo with _$MangaInfo {
  factory MangaInfo({
    required int id,
    required String name,
    required bool isReleasing,
    required bool isNSFW,
    required MangaTypeEnum type,
    required List<String> tags,
    required int chaptersCount,
    required List<String> imagesUrls,
    int? myAnimeListId,
    int? anilistId,
    double? averageScore,
    DateTime? startedAt,
    DateTime? finishedAt,
    DateTime? lastChapterDate,
  }) = _MangaInfo;

  factory MangaInfo.fromJson(Map<String, dynamic> json) =>
      _$MangaInfoFromJson(json);
}
