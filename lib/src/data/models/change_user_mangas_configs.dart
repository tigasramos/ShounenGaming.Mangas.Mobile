// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'enums/nsfw_behaviour_enum.dart';
import 'enums/reading_mode_type_enum.dart';
import 'enums/translation_language_enum.dart';

class ChangeUserMangasConfigs {
  ReadingModeTypeEnum? readingMode;
  NSFWBehaviourEnum? nsfwBehaviour;
  TranslationLanguageEnum? translationLanguage;
  bool? skipChapterToAnotherTranslation;
  bool? showProgressForChaptersWithDecimals;

  ChangeUserMangasConfigs({
    this.readingMode,
    this.nsfwBehaviour,
    this.translationLanguage,
    this.skipChapterToAnotherTranslation,
    this.showProgressForChaptersWithDecimals,
  });

  ChangeUserMangasConfigs copyWith({
    ReadingModeTypeEnum? readingMode,
    NSFWBehaviourEnum? nsfwBehaviour,
    TranslationLanguageEnum? translationLanguage,
    bool? skipChapterToAnotherTranslation,
    bool? showProgressForChaptersWithDecimals,
  }) {
    return ChangeUserMangasConfigs(
      readingMode: readingMode ?? this.readingMode,
      nsfwBehaviour: nsfwBehaviour ?? this.nsfwBehaviour,
      translationLanguage: translationLanguage ?? this.translationLanguage,
      skipChapterToAnotherTranslation: skipChapterToAnotherTranslation ??
          this.skipChapterToAnotherTranslation,
      showProgressForChaptersWithDecimals:
          showProgressForChaptersWithDecimals ??
              this.showProgressForChaptersWithDecimals,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'readingMode': readingMode?.name,
      'nsfwBehaviour': nsfwBehaviour?.name,
      'translationLanguage': translationLanguage?.name,
      'skipChapterToAnotherTranslation': skipChapterToAnotherTranslation,
      'showProgressForChaptersWithDecimals':
          showProgressForChaptersWithDecimals,
    };
  }

  factory ChangeUserMangasConfigs.fromMap(Map<String, dynamic> map) {
    return ChangeUserMangasConfigs(
      readingMode: map['readingMode'] != null
          ? ReadingModeTypeEnum.values.byName(map['readingMode'])
          : null,
      nsfwBehaviour: map['nsfwBehaviour'] != null
          ? NSFWBehaviourEnum.values.byName(map['nsfwBehaviour'])
          : null,
      translationLanguage: map['translationLanguage'] != null
          ? TranslationLanguageEnum.values.byName(map['translationLanguage'])
          : null,
      skipChapterToAnotherTranslation:
          map['skipChapterToAnotherTranslation'] != null
              ? map['skipChapterToAnotherTranslation'] as bool
              : null,
      showProgressForChaptersWithDecimals:
          map['showProgressForChaptersWithDecimals'] != null
              ? map['showProgressForChaptersWithDecimals'] as bool
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangeUserMangasConfigs.fromJson(String source) =>
      ChangeUserMangasConfigs.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChangeUserMangasConfigs(readingMode: $readingMode, nsfwBehaviour: $nsfwBehaviour, translationLanguage: $translationLanguage, skipChapterToAnotherTranslation: $skipChapterToAnotherTranslation, showProgressForChaptersWithDecimals: $showProgressForChaptersWithDecimals)';
  }

  @override
  bool operator ==(covariant ChangeUserMangasConfigs other) {
    if (identical(this, other)) return true;

    return other.readingMode == readingMode &&
        other.nsfwBehaviour == nsfwBehaviour &&
        other.translationLanguage == translationLanguage &&
        other.skipChapterToAnotherTranslation ==
            skipChapterToAnotherTranslation &&
        other.showProgressForChaptersWithDecimals ==
            showProgressForChaptersWithDecimals;
  }

  @override
  int get hashCode {
    return readingMode.hashCode ^
        nsfwBehaviour.hashCode ^
        translationLanguage.hashCode ^
        skipChapterToAnotherTranslation.hashCode ^
        showProgressForChaptersWithDecimals.hashCode;
  }
}
