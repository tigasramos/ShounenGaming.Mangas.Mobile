import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';

part 'user_chapter_read_history.freezed.dart';
part 'user_chapter_read_history.g.dart';

@freezed
class UserChapterReadHistory with _$UserChapterReadHistory {
  factory UserChapterReadHistory(
      {required DateTime readAt,
      required num numOfFirstChapter,
      num? numOfLastChapter,
      required MangaInfo manga}) = _UserChapterReadHistory;

  factory UserChapterReadHistory.fromJson(Map<String, dynamic> json) =>
      _$UserChapterReadHistoryFromJson(json);
}
