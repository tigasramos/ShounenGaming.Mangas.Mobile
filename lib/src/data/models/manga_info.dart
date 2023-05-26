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
  String imageUrl;
  MangaInfo({
    required this.id,
    required this.name,
    required this.isReleasing,
    required this.type,
    required this.tags,
    required this.chaptersCount,
    required this.imageUrl,
  });

  MangaInfo copyWith({
    int? id,
    String? name,
    bool? isReleasing,
    MangaTypeEnum? type,
    List<String>? tags,
    int? chaptersCount,
    String? imageUrl,
  }) {
    return MangaInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      isReleasing: isReleasing ?? this.isReleasing,
      type: type ?? this.type,
      tags: tags ?? this.tags,
      chaptersCount: chaptersCount ?? this.chaptersCount,
      imageUrl: imageUrl ?? this.imageUrl,
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
      'imageUrl': imageUrl,
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
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaInfo.fromJson(String source) =>
      MangaInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MangaInfo(id: $id, name: $name, isReleasing: $isReleasing, type: $type, tags: $tags, chaptersCount: $chaptersCount, imageUrl: $imageUrl)';
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
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isReleasing.hashCode ^
        type.hashCode ^
        tags.hashCode ^
        chaptersCount.hashCode ^
        imageUrl.hashCode;
  }
}
