// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'manga_translation_info.dart';

class MangaChapter {
  int id;
  String name;
  List<MangaTranslationInfo> translations;
  MangaChapter({
    required this.id,
    required this.name,
    required this.translations,
  });

  MangaChapter copyWith({
    int? id,
    String? name,
    List<MangaTranslationInfo>? translations,
  }) {
    return MangaChapter(
      id: id ?? this.id,
      name: name ?? this.name,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'translations': translations.map((x) => x.toMap()).toList(),
    };
  }

  factory MangaChapter.fromMap(Map<String, dynamic> map) {
    return MangaChapter(
      id: map['id'] as int,
      name: map['name'].toString(),
      translations: List<MangaTranslationInfo>.from(
        (map['translations']).map<MangaTranslationInfo>(
          (x) => MangaTranslationInfo.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaChapter.fromJson(String source) =>
      MangaChapter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MangaChapter(id: $id, name: $name, translations: $translations)';

  @override
  bool operator ==(covariant MangaChapter other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.translations, translations);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ translations.hashCode;
}
