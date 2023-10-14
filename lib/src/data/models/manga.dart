import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_writer.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/string_pair.dart';

import 'enums/manga_type_enum.dart';
import 'manga_chapter.dart';

class Manga {
  int id;
  String name;
  List<StringPair> alternativeNames;
  List<String> synonyms;
  String description;
  bool isReleasing;
  MangaTypeEnum type;
  List<String> tags;
  List<MangaChapter> chapters;
  List<String> imagesUrls;
  MangaWriter writer;
  double? averageScore;
  int? mangaMyAnimeListId;
  DateTime? startedAt;
  DateTime? finishedAt;
  Manga({
    required this.id,
    required this.name,
    required this.alternativeNames,
    required this.synonyms,
    required this.description,
    required this.isReleasing,
    required this.type,
    this.averageScore,
    required this.tags,
    required this.chapters,
    required this.imagesUrls,
    required this.writer,
    this.mangaMyAnimeListId,
    this.startedAt,
    this.finishedAt,
  });

  Manga copyWith({
    int? id,
    String? name,
    List<StringPair>? alternativeNames,
    List<String>? synonyms,
    String? description,
    bool? isReleasing,
    List<String>? tags,
    MangaTypeEnum? type,
    List<MangaChapter>? chapters,
    List<String>? imagesUrls,
    MangaWriter? writer,
    double? averageScore,
    int? mangaMyAnimeListId,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) {
    return Manga(
      id: id ?? this.id,
      name: name ?? this.name,
      alternativeNames: alternativeNames ?? this.alternativeNames,
      synonyms: synonyms ?? this.synonyms,
      description: description ?? this.description,
      isReleasing: isReleasing ?? this.isReleasing,
      type: type ?? this.type,
      tags: tags ?? this.tags,
      chapters: chapters ?? this.chapters,
      imagesUrls: imagesUrls ?? this.imagesUrls,
      averageScore: averageScore ?? this.averageScore,
      writer: writer ?? this.writer,
      mangaMyAnimeListId: mangaMyAnimeListId ?? this.mangaMyAnimeListId,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'alternativeNames': alternativeNames.map((x) => x.toMap()).toList(),
      'synonyms': synonyms,
      'description': description,
      'isReleasing': isReleasing,
      'type': type,
      'tags': tags,
      'chapters': chapters.map((x) => x.toMap()).toList(),
      'imagesUrls': imagesUrls,
      'averageScore': averageScore,
      'writer': writer,
      'mangaMyAnimeListId': mangaMyAnimeListId,
      'startedAt': startedAt?.toString(),
      'finishedAt': finishedAt?.toString(),
    };
  }

  factory Manga.fromMap(Map<String, dynamic> map) {
    return Manga(
      id: map['id'] as int,
      name: map['name'] as String,
      alternativeNames: List<StringPair>.from(
        (map['alternativeNames']).map<StringPair>(
          (x) => StringPair.fromMap(x as Map<String, dynamic>),
        ),
      ),
      synonyms: List<String>.from(map['synonyms']),
      description: map['description'] as String,
      isReleasing: map['isReleasing'] as bool,
      tags: List<String>.from(map['tags']),
      type: MangaTypeEnum.values.byName(map['type']),
      chapters: List<MangaChapter>.from(
        (map['chapters']).map<MangaChapter>(
          (x) => MangaChapter.fromMap(x as Map<String, dynamic>),
        ),
      ),
      imagesUrls: List<String>.from(map['imagesUrls']),
      writer: MangaWriter.fromMap(map['writer']),
      averageScore: map["averageScore"] != null
          ? double.parse(map["averageScore"].toString())
          : null,
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
    return 'Manga(id: $id, name: $name, alternativeNames: $alternativeNames, averageScore: $averageScore description: $description, isReleasing: $isReleasing, tags: $tags, chapters: $chapters, imagesUrls: $imagesUrls, writer: $writer, mangaMyAnimeListId: $mangaMyAnimeListId, startedAt: $startedAt, finishedAt: $finishedAt)';
  }

  @override
  bool operator ==(covariant Manga other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.alternativeNames, alternativeNames) &&
        other.description == description &&
        other.isReleasing == isReleasing &&
        other.averageScore == averageScore &&
        listEquals(other.synonyms, synonyms) &&
        listEquals(other.tags, tags) &&
        listEquals(other.chapters, chapters) &&
        listEquals(other.imagesUrls, imagesUrls) &&
        other.type == type &&
        other.writer == writer &&
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
        synonyms.hashCode ^
        isReleasing.hashCode ^
        averageScore.hashCode ^
        tags.hashCode ^
        type.hashCode ^
        chapters.hashCode ^
        imagesUrls.hashCode ^
        writer.hashCode ^
        mangaMyAnimeListId.hashCode ^
        startedAt.hashCode ^
        finishedAt.hashCode;
  }
}
