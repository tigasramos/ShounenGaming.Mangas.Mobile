// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'enums/manga_type_enum.dart';

class MangaInfo {
  int id;
  String name;
  bool isReleasing;
  MangaTypeEnum type;
  List<String> tags;
  int chaptersCount;
  List<String> imagesUrls;
  int? myAnimeListId;
  int? anilistId;
  DateTime? startedAt;
  DateTime? finishedAt;
  DateTime? lastChapterDate;
  MangaInfo({
    required this.id,
    required this.name,
    required this.isReleasing,
    required this.type,
    required this.tags,
    required this.chaptersCount,
    required this.imagesUrls,
    this.myAnimeListId,
    this.anilistId,
    this.startedAt,
    this.finishedAt,
    this.lastChapterDate,
  });

  MangaInfo copyWith({
    int? id,
    String? name,
    bool? isReleasing,
    MangaTypeEnum? type,
    List<String>? tags,
    int? chaptersCount,
    List<String>? imagesUrls,
    int? myAnimeListId,
    int? anilistId,
    DateTime? startedAt,
    DateTime? finishedAt,
    DateTime? lastChapterDate,
  }) {
    return MangaInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      isReleasing: isReleasing ?? this.isReleasing,
      type: type ?? this.type,
      tags: tags ?? this.tags,
      chaptersCount: chaptersCount ?? this.chaptersCount,
      imagesUrls: imagesUrls ?? this.imagesUrls,
      myAnimeListId: myAnimeListId ?? this.myAnimeListId,
      anilistId: anilistId ?? this.anilistId,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      lastChapterDate: lastChapterDate ?? this.lastChapterDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isReleasing': isReleasing,
      'type': type.name,
      'tags': tags,
      'chaptersCount': chaptersCount,
      'imagesUrls': imagesUrls,
      'myAnimeListId': myAnimeListId,
      'anilistId': anilistId,
      'startedAt': startedAt?.toString(),
      'finishedAt': finishedAt?.toString(),
      'lastChapterDate': lastChapterDate?.toString(),
    };
  }

  factory MangaInfo.fromMap(Map<String, dynamic> map) {
    return MangaInfo(
      id: map['id'] as int,
      name: map['name'] as String,
      isReleasing: map['isReleasing'] as bool,
      type: MangaTypeEnum.values.byName(map['type']),
      tags: List<String>.from(map['tags']),
      chaptersCount: map['chaptersCount'] as int,
      imagesUrls: List<String>.from(map['imagesUrls']),
      myAnimeListId:
          map['myAnimeListId'] != null ? map['myAnimeListId'] as int : null,
      anilistId: map['anilistId'] != null ? map['anilistId'] as int : null,
      startedAt:
          map['startedAt'] != null ? DateTime.parse(map['startedAt']) : null,
      finishedAt:
          map['finishedAt'] != null ? DateTime.parse(map['finishedAt']) : null,
      lastChapterDate: map['lastChapterDate'] != null
          ? DateTime.parse(map['lastChapterDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaInfo.fromJson(String source) =>
      MangaInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MangaInfo(id: $id, name: $name, isReleasing: $isReleasing, type: $type, tags: $tags, chaptersCount: $chaptersCount, imageUrl: $imagesUrls, myAnimeListId: $myAnimeListId, anilistId: $anilistId, startedAt: $startedAt, finishedAt: $finishedAt, lastChapterDate: $lastChapterDate)';
  }

  @override
  bool operator ==(covariant MangaInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isReleasing == isReleasing &&
        other.type == type &&
        listEquals(other.tags, tags) &&
        other.chaptersCount == chaptersCount &&
        listEquals(other.imagesUrls, imagesUrls) &&
        other.myAnimeListId == myAnimeListId &&
        other.anilistId == anilistId &&
        other.startedAt == startedAt &&
        other.finishedAt == finishedAt &&
        other.lastChapterDate == lastChapterDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isReleasing.hashCode ^
        type.hashCode ^
        tags.hashCode ^
        chaptersCount.hashCode ^
        imagesUrls.hashCode ^
        myAnimeListId.hashCode ^
        anilistId.hashCode ^
        startedAt.hashCode ^
        finishedAt.hashCode ^
        lastChapterDate.hashCode;
  }
}
