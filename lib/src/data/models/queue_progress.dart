import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/manga_source_enum.dart';

part 'queue_progress.freezed.dart';
part 'queue_progress.g.dart';

@freezed
class QueueProgress with _$QueueProgress {
  factory QueueProgress({
    required double percentage,
    required MangaSourceEnum currentSource,
    required int currentChapter,
    required int totalChapters,
  }) = _QueueProgress;

  factory QueueProgress.fromJson(Map<String, dynamic> json) =>
      _$QueueProgressFromJson(json);
}
