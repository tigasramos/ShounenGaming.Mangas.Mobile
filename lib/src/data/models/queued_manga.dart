import 'package:freezed_annotation/freezed_annotation.dart';

import 'manga_info.dart';
import 'queue_progress.dart';
import 'simple_user.dart';

part 'queued_manga.freezed.dart';
part 'queued_manga.g.dart';

@freezed
class QueuedManga with _$QueuedManga {
  factory QueuedManga({
    required MangaInfo manga,
    QueueProgress? progress,
    SimpleUser? queuedByUser,
    required DateTime queuedAt,
  }) = _QueuedManga;

  factory QueuedManga.fromJson(Map<String, dynamic> json) =>
      _$QueuedMangaFromJson(json);
}
