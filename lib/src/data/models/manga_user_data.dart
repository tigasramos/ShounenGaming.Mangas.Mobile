// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';

class MangaUserData {
  int userId;
  MangaInfo manga;
  MangaUserStatusEnum? status;
  double? rating;
  int filteredReadChapters;
  int filteredTotalChapters;
  DateTime? addedToStatusDate;
  DateTime? startedReadingDate;
  DateTime? finishedReadingDate;
  List<int> chaptersRead;
  MangaUserData({
    required this.userId,
    required this.manga,
    this.status,
    this.rating,
    required this.filteredReadChapters,
    required this.filteredTotalChapters,
    this.addedToStatusDate,
    this.startedReadingDate,
    this.finishedReadingDate,
    required this.chaptersRead,
  });

  MangaUserData copyWith({
    int? userId,
    MangaInfo? manga,
    MangaUserStatusEnum? status,
    int? filteredReadChapters,
    int? filteredTotalChapters,
    DateTime? addedToStatusDate,
    DateTime? startedReadingDate,
    DateTime? finishedReadingDate,
    List<int>? chaptersRead,
  }) {
    return MangaUserData(
      userId: userId ?? this.userId,
      manga: manga ?? this.manga,
      status: status ?? this.status,
      filteredReadChapters: filteredReadChapters ?? this.filteredReadChapters,
      filteredTotalChapters:
          filteredTotalChapters ?? this.filteredTotalChapters,
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
      'status': status?.name,
      'rating': rating,
      'filteredReadChapters': filteredReadChapters,
      'filteredTotalChapters': filteredTotalChapters,
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
      status: map['status'] != null
          ? MangaUserStatusEnum.values.byName(map['status'])
          : null,
      rating:
          map['rating'] != null ? double.parse(map['rating'].toString()) : null,
      filteredReadChapters: map['filteredReadChapters'] as int,
      filteredTotalChapters: map['filteredTotalChapters'] as int,
      addedToStatusDate: map['addedToStatusDate'] != null
          ? DateTime.parse(map['addedToStatusDate'])
          : null,
      startedReadingDate: map['startedReadingDate'] != null
          ? DateTime.parse(map['startedReadingDate'])
          : null,
      finishedReadingDate: map['finishedReadingDate'] != null
          ? DateTime.parse(map['finishedReadingDate'])
          : null,
      chaptersRead: List<int>.from(map['chaptersRead']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaUserData.fromJson(String source) =>
      MangaUserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MangaUserData(userId: $userId, manga: $manga, rating: $rating, filteredReadChapters: $filteredReadChapters, filteredTotalChapters: $filteredTotalChapters, status: $status, addedToStatusDate: $addedToStatusDate, startedReadingDate: $startedReadingDate, finishedReadingDate: $finishedReadingDate, chaptersRead: $chaptersRead)';
  }

  @override
  bool operator ==(covariant MangaUserData other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.manga == manga &&
        other.filteredReadChapters == filteredReadChapters &&
        other.filteredTotalChapters == filteredTotalChapters &&
        other.rating == rating &&
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
        filteredReadChapters.hashCode ^
        filteredTotalChapters.hashCode ^
        status.hashCode ^
        rating.hashCode ^
        addedToStatusDate.hashCode ^
        startedReadingDate.hashCode ^
        finishedReadingDate.hashCode ^
        chaptersRead.hashCode;
  }
}
