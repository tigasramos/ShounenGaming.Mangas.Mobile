// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_metadata_source_enum.dart';

class MangaMetadata {
  int id;
  MangaMetadataSourceEnum source;
  List<String> titles;
  String imageUrl;
  bool alreadyExists;
  String type;
  String description;
  String status;
  num? score;
  List<String> tags;
  DateTime? startedAt;
  DateTime? finishedAt;
  MangaMetadata({
    required this.id,
    required this.titles,
    required this.imageUrl,
    required this.alreadyExists,
    required this.type,
    required this.description,
    required this.source,
    required this.status,
    this.score,
    required this.tags,
    this.startedAt,
    this.finishedAt,
  });

  MangaMetadata copyWith({
    int? id,
    List<String>? titles,
    String? imageUrl,
    String? type,
    String? description,
    MangaMetadataSourceEnum? source,
    bool? alreadyExists,
    String? status,
    num? score,
    List<String>? tags,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) {
    return MangaMetadata(
      id: id ?? this.id,
      titles: titles ?? this.titles,
      source: source ?? this.source,
      imageUrl: imageUrl ?? this.imageUrl,
      alreadyExists: alreadyExists ?? this.alreadyExists,
      type: type ?? this.type,
      description: description ?? this.description,
      status: status ?? this.status,
      score: score ?? this.score,
      tags: tags ?? this.tags,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titles': titles,
      'imageUrl': imageUrl,
      'type': type,
      'description': description,
      'alreadyExists': alreadyExists,
      'source': source.name,
      'status': status,
      'score': score,
      'tags': tags,
      'startedAt': startedAt?.toString(),
      'finishedAt': finishedAt?.toString(),
    };
  }

  factory MangaMetadata.fromMap(Map<String, dynamic> map) {
    return MangaMetadata(
      id: map['id'] as int,
      titles: map['titles'] != null ? List<String>.from(map['titles']) : [],
      imageUrl: map['imageUrl'] as String,
      type: map['type'] != null ? map['type'].toString() : '',
      description:
          map['description'] != null ? map['description'].toString() : "",
      alreadyExists: map['alreadyExists'] as bool,
      status: map['status'] != null ? map['status'].toString() : '',
      score: map['score'] != null ? map['score'] as num : null,
      source: MangaMetadataSourceEnum.values.byName(map['source'].toString()),
      tags: map['tags'] != null ? List<String>.from(map['tags']) : [],
      startedAt:
          map['startedAt'] != null ? DateTime.parse(map['startedAt']) : null,
      finishedAt:
          map['finishedAt'] != null ? DateTime.parse(map['finishedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaMetadata.fromJson(String source) =>
      MangaMetadata.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MangaMetadata(id: $id, titles: $titles, imageUrl: $imageUrl, alreadyExists: $alreadyExists source: $source, type: $type, description: $description, status: $status, score: $score, tags: $tags, startedAt: $startedAt, finishedAt: $finishedAt)';
  }

  @override
  bool operator ==(covariant MangaMetadata other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.titles, titles) &&
        other.imageUrl == imageUrl &&
        other.type == type &&
        other.alreadyExists == alreadyExists &&
        other.description == description &&
        other.status == status &&
        other.source == source &&
        other.score == score &&
        listEquals(other.tags, tags) &&
        other.startedAt == startedAt &&
        other.finishedAt == finishedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        titles.hashCode ^
        imageUrl.hashCode ^
        type.hashCode ^
        source.hashCode ^
        alreadyExists.hashCode ^
        description.hashCode ^
        status.hashCode ^
        score.hashCode ^
        tags.hashCode ^
        startedAt.hashCode ^
        finishedAt.hashCode;
  }
}
