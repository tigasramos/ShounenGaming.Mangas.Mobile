import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'manga_translation.dart';

class MangaChapter {
  String name;
  List<MangaTranslation> translations;
  MangaChapter({
    required this.name,
    required this.translations,
  });

  MangaChapter copyWith({
    String? name,
    List<MangaTranslation>? translations,
  }) {
    return MangaChapter(
      name: name ?? this.name,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'translations': translations.map((x) => x.toMap()).toList(),
    };
  }

  factory MangaChapter.fromMap(Map<String, dynamic> map) {
    return MangaChapter(
      name: map['name'] as String,
      translations: List<MangaTranslation>.from(
        (map['translations'] as List<int>).map<MangaTranslation>(
          (x) => MangaTranslation.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaChapter.fromJson(String source) =>
      MangaChapter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MangaChapter(name: $name, translations: $translations)';

  @override
  bool operator ==(covariant MangaChapter other) {
    if (identical(this, other)) return true;

    return other.name == name && listEquals(other.translations, translations);
  }

  @override
  int get hashCode => name.hashCode ^ translations.hashCode;
}
