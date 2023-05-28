// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';

class MangaUserData {
  int userId;
  MangaInfo manga;
  MangaUserStatusEnum status;
  DateTime? addedToStatusDate;
  DateTime? startedReadingDate;
  DateTime? finishedReadingDate;
  int chaptersRead;
  MangaUserData({
    required this.userId,
    required this.manga,
    required this.status,
    this.addedToStatusDate,
    this.startedReadingDate,
    this.finishedReadingDate,
    required this.chaptersRead,
  });

  MangaUserData copyWith({
    int? userId,
    MangaInfo? manga,
    MangaUserStatusEnum? status,
    DateTime? addedToStatusDate,
    DateTime? startedReadingDate,
    DateTime? finishedReadingDate,
    int? chaptersRead,
  }) {
    return MangaUserData(
      userId: userId ?? this.userId,
      manga: manga ?? this.manga,
      status: status ?? this.status,
      addedToStatusDate: addedToStatusDate ?? this.addedToStatusDate,
      startedReadingDate: startedReadingDate ?? this.startedReadingDate,
      finishedReadingDate: finishedReadingDate ?? this.finishedReadingDate,
      chaptersRead: chaptersRead ?? this.chaptersRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'manga': manga.toMap(),
      'status': status.name,
      'addedToStatusDate': addedToStatusDate?.toString(),
      'startedReadingDate': startedReadingDate?.toString(),
      'finishedReadingDate': finishedReadingDate?.toString(),
      'chaptersRead': chaptersRead,
    };
  }

  factory MangaUserData.fromMap(Map<String, dynamic> map) {
    return MangaUserData(
      userId: map['userId'] as int,
      manga: MangaInfo.fromMap(map['manga'] as Map<String, dynamic>),
      status: MangaUserStatusEnum.values.byName(map['status']),
      addedToStatusDate: map['addedToStatusDate'] != null
          ? DateTime.parse(map['addedToStatusDate'])
          : null,
      startedReadingDate: map['startedReadingDate'] != null
          ? DateTime.parse(map['startedReadingDate'])
          : null,
      finishedReadingDate: map['finishedReadingDate'] != null
          ? DateTime.parse(map['finishedReadingDate'])
          : null,
      chaptersRead: map['chaptersRead'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaUserData.fromJson(String source) =>
      MangaUserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MangaUserData(userId: $userId, manga: $manga, status: $status, addedToStatusDate: $addedToStatusDate, startedReadingDate: $startedReadingDate, finishedReadingDate: $finishedReadingDate, chaptersRead: $chaptersRead)';
  }

  @override
  bool operator ==(covariant MangaUserData other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.manga == manga &&
        other.status == status &&
        other.addedToStatusDate == addedToStatusDate &&
        other.startedReadingDate == startedReadingDate &&
        other.finishedReadingDate == finishedReadingDate &&
        other.chaptersRead == chaptersRead;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        manga.hashCode ^
        status.hashCode ^
        addedToStatusDate.hashCode ^
        startedReadingDate.hashCode ^
        finishedReadingDate.hashCode ^
        chaptersRead.hashCode;
  }
}
