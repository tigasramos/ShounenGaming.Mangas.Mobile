// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';

class ChapterRelease {
  int id;
  String name;
  DateTime createdAt;
  MangaInfo manga;
  ChapterRelease({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.manga,
  });

  ChapterRelease copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    MangaInfo? manga,
  }) {
    return ChapterRelease(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      manga: manga ?? this.manga,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt.toString(),
      'manga': manga.toMap(),
    };
  }

  factory ChapterRelease.fromMap(Map<String, dynamic> map) {
    return ChapterRelease(
      id: map['id'] as int,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      manga: MangaInfo.fromMap(map['manga'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterRelease.fromJson(String source) =>
      ChapterRelease.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChapterRelease(id: $id, name: $name, createdAt: $createdAt, manga: $manga)';
  }

  @override
  bool operator ==(covariant ChapterRelease other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.manga == manga;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ createdAt.hashCode ^ manga.hashCode;
  }
}
