import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'enums/manga_type_enum.dart';
import 'manga_chapter.dart';

class Manga {
  int id;
  String name;
  Map<String, String> alternativeNames;
  String description;
  bool isReleasing;
  MangaTypeEnum type;
  List<String> tags;
  List<MangaChapter> chapters;
  String imageUrl;
  //Writer
  int? mangaMyAnimeListId;
  DateTime? startedAt;
  DateTime? finishedAt;
  Manga({
    required this.id,
    required this.name,
    required this.alternativeNames,
    required this.description,
    required this.isReleasing,
    required this.type,
    required this.tags,
    required this.chapters,
    required this.imageUrl,
    this.mangaMyAnimeListId,
    this.startedAt,
    this.finishedAt,
  });

  Manga copyWith({
    int? id,
    String? name,
    Map<String, String>? alternativeNames,
    String? description,
    bool? isReleasing,
    List<String>? tags,
    MangaTypeEnum? type,
    List<MangaChapter>? chapters,
    String? imageUrl,
    int? mangaMyAnimeListId,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) {
    return Manga(
      id: id ?? this.id,
      name: name ?? this.name,
      alternativeNames: alternativeNames ?? this.alternativeNames,
      description: description ?? this.description,
      isReleasing: isReleasing ?? this.isReleasing,
      type: type ?? this.type,
      tags: tags ?? this.tags,
      chapters: chapters ?? this.chapters,
      imageUrl: imageUrl ?? this.imageUrl,
      mangaMyAnimeListId: mangaMyAnimeListId ?? this.mangaMyAnimeListId,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'alternativeNames': alternativeNames,
      'description': description,
      'isReleasing': isReleasing,
      'type': type,
      'tags': tags,
      'chapters': chapters.map((x) => x.toMap()).toList(),
      'imageUrl': imageUrl,
      'mangaMyAnimeListId': mangaMyAnimeListId,
      'startedAt': startedAt?.toString(),
      'finishedAt': finishedAt?.toString(),
    };
  }

  factory Manga.fromMap(Map<String, dynamic> map) {
    return Manga(
      id: map['id'] as int,
      name: map['name'] as String,
      alternativeNames: Map<String, String>.from(
          map['alternativeNames'] as Map<String, String>),
      description: map['description'] as String,
      isReleasing: map['isReleasing'] as bool,
      tags: List<String>.from(map['tags'] as List<String>),
      type: MangaTypeEnum.values.byName(map['type']),
      chapters: List<MangaChapter>.from(
        (map['chapters'] as List<int>).map<MangaChapter>(
          (x) => MangaChapter.fromMap(x as Map<String, dynamic>),
        ),
      ),
      imageUrl: map['imageUrl'] as String,
      mangaMyAnimeListId: map['mangaMyAnimeListId'] != null
          ? map['mangaMyAnimeListId'] as int
          : null,
      startedAt:
          map['startedAt'] != null ? DateTime.parse(map['startedAt']) : null,
      finishedAt:
          map['finishedAt'] != null ? DateTime.parse(map['finishedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Manga.fromJson(String source) =>
      Manga.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Manga(id: $id, name: $name, alternativeNames: $alternativeNames, description: $description, isReleasing: $isReleasing, tags: $tags, chapters: $chapters, imageUrl: $imageUrl, mangaMyAnimeListId: $mangaMyAnimeListId, startedAt: $startedAt, finishedAt: $finishedAt)';
  }

  @override
  bool operator ==(covariant Manga other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        mapEquals(other.alternativeNames, alternativeNames) &&
        other.description == description &&
        other.isReleasing == isReleasing &&
        listEquals(other.tags, tags) &&
        listEquals(other.chapters, chapters) &&
        other.imageUrl == imageUrl &&
        other.type == type &&
        other.mangaMyAnimeListId == mangaMyAnimeListId &&
        other.startedAt == startedAt &&
        other.finishedAt == finishedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        alternativeNames.hashCode ^
        description.hashCode ^
        isReleasing.hashCode ^
        tags.hashCode ^
        type.hashCode ^
        chapters.hashCode ^
        imageUrl.hashCode ^
        mangaMyAnimeListId.hashCode ^
        startedAt.hashCode ^
        finishedAt.hashCode;
  }
}
