import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/user_activity_type_enum.dart';

import 'manga_info.dart';
import 'simple_user.dart';

part 'manga_user_activity.freezed.dart';
part 'manga_user_activity.g.dart';

@freezed
class MangaUserActivity with _$MangaUserActivity {
  factory MangaUserActivity({
    required SimpleUser user,
    required MangaInfo manga,
    required DateTime madeAt,
    required UserActivityTypeEnum activityType,
    double? firstChapterRead,
    double? lastChapterRead,
    MangaUserStatusEnum? previousState,
    MangaUserStatusEnum? newState,
  }) = _MangaUserActivity;

  factory MangaUserActivity.fromJson(Map<String, dynamic> json) =>
      _$MangaUserActivityFromJson(json);
}
