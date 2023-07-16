import 'dart:convert';

import 'enums/translation_language_enum.dart';

class MangaTranslationInfo {
  int id;
  TranslationLanguageEnum language;
  DateTime createdAt;
  MangaTranslationInfo({
    required this.id,
    required this.language,
    required this.createdAt,
  });

  MangaTranslationInfo copyWith({
    int? id,
    TranslationLanguageEnum? language,
    DateTime? createdAt,
  }) {
    return MangaTranslationInfo(
      id: id ?? this.id,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'language': language.name,
      'createdAt': createdAt.toString(),
    };
  }

  factory MangaTranslationInfo.fromMap(Map<String, dynamic> map) {
    return MangaTranslationInfo(
      id: map['id'] as int,
      language: TranslationLanguageEnum.values.byName(map['language']),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaTranslationInfo.fromJson(String source) =>
      MangaTranslationInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MangaTranslation(id: $id, language: $language, createdAt: $createdAt)';

  @override
  bool operator ==(covariant MangaTranslationInfo other) {
    if (identical(this, other)) return true;

    return other.language == language &&
        other.createdAt == createdAt &&
        other.id == id;
  }

  @override
  int get hashCode => language.hashCode ^ createdAt.hashCode ^ id.hashCode;
}
