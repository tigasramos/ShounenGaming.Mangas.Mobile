import 'dart:convert';

import 'enums/translation_language_enum.dart';

class MangaTranslation {
  TranslationLanguageEnum language;
  DateTime? releasedDate;
  MangaTranslation({
    required this.language,
    this.releasedDate,
  });

  MangaTranslation copyWith({
    TranslationLanguageEnum? language,
    DateTime? releasedDate,
  }) {
    return MangaTranslation(
      language: language ?? this.language,
      releasedDate: releasedDate ?? this.releasedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language.name,
      'releasedDate': releasedDate?.toString(),
    };
  }

  factory MangaTranslation.fromMap(Map<String, dynamic> map) {
    return MangaTranslation(
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
      'MangaTranslation(language: $language, releasedDate: $releasedDate)';

  @override
  bool operator ==(covariant MangaTranslation other) {
    if (identical(this, other)) return true;

    return other.language == language && other.releasedDate == releasedDate;
  }

  @override
  int get hashCode => language.hashCode ^ releasedDate.hashCode;
}
