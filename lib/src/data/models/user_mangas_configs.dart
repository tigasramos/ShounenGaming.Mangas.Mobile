import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/nsfw_behaviour_enum.dart';
import 'enums/reading_mode_type_enum.dart';
import 'enums/translation_language_enum.dart';

part 'user_mangas_configs.freezed.dart';
part 'user_mangas_configs.g.dart';

@freezed
class UserMangasConfigs with _$UserMangasConfigs {
  factory UserMangasConfigs({
    required ReadingModeTypeEnum readingMode,
    required NSFWBehaviourEnum nsfwBehaviour,
    required TranslationLanguageEnum translationLanguage,
    required bool skipChapterToAnotherTranslation,
    required bool showProgressForChaptersWithDecimals,
  }) = _UserMangasConfigs;

  factory UserMangasConfigs.fromJson(Map<String, dynamic> json) =>
      _$UserMangasConfigsFromJson(json);
}
