import 'dart:convert';

import 'enums/translation_language_enum.dart';

class MangaTranslation {
  int id;
  TranslationLanguageEnum language;
  DateTime? releasedDate;
  MangaTranslation({
    required this.id,
    required this.language,
    this.releasedDate,
  });

  MangaTranslation copyWith({
    int? id,
    TranslationLanguageEnum? language,
    DateTime? releasedDate,
  }) {
    return MangaTranslation(
      id: id ?? this.id,
      language: language ?? this.language,
      releasedDate: releasedDate ?? this.releasedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'language': language.name,
      'releasedDate': releasedDate?.toString(),
    };
  }

  factory MangaTranslation.fromMap(Map<String, dynamic> map) {
    return MangaTranslation(
      id: map['id'] as int,
      language: TranslationLanguageEnum.values.byName(map['language']),
      releasedDate: map['releasedDate'] != null
          ? DateTime.parse(map['releasedDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaTranslation.fromJson(String source) =>
      MangaTranslation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MangaTranslation(id: $id, language: $language, releasedDate: $releasedDate)';

  @override
  bool operator ==(covariant MangaTranslation other) {
    if (identical(this, other)) return true;

    return other.language == language &&
        other.releasedDate == releasedDate &&
        other.id == id;
  }

  @override
  int get hashCode => language.hashCode ^ releasedDate.hashCode ^ id.hashCode;
}
