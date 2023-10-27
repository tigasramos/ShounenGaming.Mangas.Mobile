import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/manga_user_status_enum.dart';
import 'manga_info.dart';

part 'manga_user_data.freezed.dart';
part 'manga_user_data.g.dart';

@freezed
class MangaUserData with _$MangaUserData {
  factory MangaUserData(
      {required int userId,
      required MangaInfo manga,
      MangaUserStatusEnum? status,
      double? rating,
      required int filteredReadChapters,
      required int filteredTotalChapters,
      DateTime? addedToStatusDate,
      DateTime? startedReadingDate,
      DateTime? finishedReadingDate,
      required List<int> chaptersRead}) = _MangaUserData;

  factory MangaUserData.fromJson(Map<String, dynamic> json) =>
      _$MangaUserDataFromJson(json);
}
