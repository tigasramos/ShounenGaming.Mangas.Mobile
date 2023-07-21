// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/nsfw_behaviour_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/reading_mode_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';

class UserMangasConfigs {
  ReadingModeTypeEnum readingMode;
  NSFWBehaviourEnum nsfwBehaviour;
  TranslationLanguageEnum translationLanguage;
  bool skipChapterToAnotherTranslation;
  bool showProgressForChaptersWithDecimals;

  UserMangasConfigs({
    required this.readingMode,
    required this.nsfwBehaviour,
    required this.translationLanguage,
    required this.skipChapterToAnotherTranslation,
    required this.showProgressForChaptersWithDecimals,
  });

  UserMangasConfigs copyWith({
    ReadingModeTypeEnum? readingMode,
    NSFWBehaviourEnum? nsfwBehaviour,
    TranslationLanguageEnum? translationLanguage,
    bool? skipChapterToAnotherTranslation,
    bool? showProgressForChaptersWithDecimals,
  }) {
    return UserMangasConfigs(
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
      'readingMode': readingMode.name,
      'nsfwBehaviour': nsfwBehaviour.name,
      'translationLanguage': translationLanguage.name,
      'skipChapterToAnotherTranslation': skipChapterToAnotherTranslation,
      'showProgressForChaptersWithDecimals':
          showProgressForChaptersWithDecimals,
    };
  }

  factory UserMangasConfigs.fromMap(Map<String, dynamic> map) {
    return UserMangasConfigs(
      readingMode: ReadingModeTypeEnum.values.byName(map['readingMode']),
      nsfwBehaviour: NSFWBehaviourEnum.values.byName(map['nsfwBehaviour']),
      translationLanguage:
          TranslationLanguageEnum.values.byName(map['translationLanguage']),
      skipChapterToAnotherTranslation:
          map['skipChapterToAnotherTranslation'] as bool,
      showProgressForChaptersWithDecimals:
          map['showProgressForChaptersWithDecimals'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserMangasConfigs.fromJson(String source) =>
      UserMangasConfigs.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserMangasConfigs(readingMode: $readingMode, nsfwBehaviour: $nsfwBehaviour, translationLanguage: $translationLanguage, skipChapterToAnotherTranslation: $skipChapterToAnotherTranslation, showProgressForChaptersWithDecimals: $showProgressForChaptersWithDecimals)';
  }

  @override
  bool operator ==(covariant UserMangasConfigs other) {
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
