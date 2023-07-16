// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';

class ChapterRelease {
  int id;
  String name;
  DateTime createdAt;
  TranslationLanguageEnum translation;
  ChapterRelease({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.translation,
  });

  ChapterRelease copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    TranslationLanguageEnum? translation,
  }) {
    return ChapterRelease(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      translation: translation ?? this.translation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'createdAt': createdAt.toString(),
      'translation': translation.name,
    };
  }

  factory ChapterRelease.fromMap(Map<String, dynamic> map) {
    return ChapterRelease(
      id: map['id'] as int,
      name: map['name'].toString(),
      createdAt: DateTime.parse(map['createdAt']),
      translation: TranslationLanguageEnum.values.byName(map['translation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterRelease.fromJson(String source) =>
      ChapterRelease.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChapterRelease(id: $id, name: $name, createdAt: $createdAt, translation: $translation)';
  }

  @override
  bool operator ==(covariant ChapterRelease other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.translation == translation;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        translation.hashCode;
  }
}
