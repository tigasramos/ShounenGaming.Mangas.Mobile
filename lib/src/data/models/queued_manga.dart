// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/queue_progress.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/simple_user.dart';

class QueuedManga {
  MangaInfo manga;
  QueueProgress? progress;
  SimpleUser? queuedByUser;
  DateTime queuedAt;
  QueuedManga({
    required this.manga,
    required this.progress,
    this.queuedByUser,
    required this.queuedAt,
  });

  QueuedManga copyWith({
    MangaInfo? manga,
    QueueProgress? progress,
    SimpleUser? queuedByUser,
    DateTime? queuedAt,
  }) {
    return QueuedManga(
      manga: manga ?? this.manga,
      progress: progress ?? this.progress,
      queuedByUser: queuedByUser ?? this.queuedByUser,
      queuedAt: queuedAt ?? this.queuedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'manga': manga.toMap(),
      'progress': progress?.toMap(),
      'queuedByUser': queuedByUser?.toMap(),
      'queuedAt': queuedAt.toString(),
    };
  }

  factory QueuedManga.fromMap(Map<String, dynamic> map) {
    return QueuedManga(
      manga: MangaInfo.fromMap(map['manga'] as Map<String, dynamic>),
      progress: map['progress'] != null
          ? QueueProgress.fromMap(map['progress'] as Map<String, dynamic>)
          : null,
      queuedByUser: map['queuedByUser'] != null
          ? SimpleUser.fromMap(map['queuedByUser'] as Map<String, dynamic>)
          : null,
      queuedAt: DateTime.parse(map['queuedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory QueuedManga.fromJson(String source) =>
      QueuedManga.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QueuedManga(manga: $manga, progress: $progress, queuedByUser: $queuedByUser, queuedAt: $queuedAt)';
  }

  @override
  bool operator ==(covariant QueuedManga other) {
    if (identical(this, other)) return true;

    return other.manga == manga &&
        other.progress == progress &&
        other.queuedByUser == queuedByUser &&
        other.queuedAt == queuedAt;
  }

  @override
  int get hashCode {
    return manga.hashCode ^
        progress.hashCode ^
        queuedByUser.hashCode ^
        queuedAt.hashCode;
  }
}
