import 'dart:convert';

import 'enums/translation_language_enum.dart';

class MangaTranslationInfo {
  int id;
  TranslationLanguageEnum language;
  DateTime? releasedDate;
  MangaTranslationInfo({
    required this.id,
    required this.language,
    this.releasedDate,
  });

  MangaTranslationInfo copyWith({
    int? id,
    TranslationLanguageEnum? language,
    DateTime? releasedDate,
  }) {
    return MangaTranslationInfo(
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

  factory MangaTranslationInfo.fromMap(Map<String, dynamic> map) {
    return MangaTranslationInfo(
      id: map['id'] as int,
      language: TranslationLanguageEnum.values.byName(map['language']),
      releasedDate: map['releasedDate'] != null
          ? DateTime.parse(map['releasedDate'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaTranslationInfo.fromJson(String source) =>
      MangaTranslationInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MangaTranslation(id: $id, language: $language, releasedDate: $releasedDate)';

  @override
  bool operator ==(covariant MangaTranslationInfo other) {
    if (identical(this, other)) return true;

    return other.language == language &&
        other.releasedDate == releasedDate &&
        other.id == id;
  }

  @override
  int get hashCode => language.hashCode ^ releasedDate.hashCode ^ id.hashCode;
}
