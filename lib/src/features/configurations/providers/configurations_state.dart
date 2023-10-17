import 'package:shounengaming_mangas_mobile/src/data/models/enums/nsfw_behaviour_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/reading_mode_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';

class ConfigurationsState {
  ReadingModeTypeEnum? readingMode;
  NSFWBehaviourEnum? nsfwBehaviour;
  TranslationLanguageEnum? language;
  bool? skipTranslations;
  bool? showRealProgress;

  bool isSaving;
  ConfigurationsState({
    this.readingMode,
    this.nsfwBehaviour,
    this.language,
    this.skipTranslations,
    this.showRealProgress,
    this.isSaving = false,
  });

  ConfigurationsState copyWith({
    ReadingModeTypeEnum? readingMode,
    NSFWBehaviourEnum? nsfwBehaviour,
    TranslationLanguageEnum? language,
    bool? skipTranslations,
    bool? showRealProgress,
    bool? isSaving,
  }) {
    return ConfigurationsState(
      readingMode: readingMode ?? this.readingMode,
      nsfwBehaviour: nsfwBehaviour ?? this.nsfwBehaviour,
      language: language ?? this.language,
      skipTranslations: skipTranslations ?? this.skipTranslations,
      showRealProgress: showRealProgress ?? this.showRealProgress,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
