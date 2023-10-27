import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';

import 'enums/manga_type_enum.dart';

part 'user_manga_main_stats.freezed.dart';
part 'user_manga_main_stats.g.dart';

@freezed
class UserMangaMainStats with _$UserMangaMainStats {
  factory UserMangaMainStats(
      {required int numOfMangas,
      required int numOfChapters,
      required num averageScore,
      required Map<MangaTypeEnum, int> mangaTypeCounters,
      required Map<MangaUserStatusEnum, int> mangaUserStatusCounters,
      required Map<DateTime, int> dailyActivityCounters,
      required Map<String, int> mangaTagsCounters}) = _UserMangaMainStats;

  factory UserMangaMainStats.fromJson(Map<String, dynamic> json) =>
      _$UserMangaMainStatsFromJson(json);
}
