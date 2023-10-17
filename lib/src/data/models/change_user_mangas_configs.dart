import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/nsfw_behaviour_enum.dart';
import 'enums/reading_mode_type_enum.dart';
import 'enums/translation_language_enum.dart';

part 'change_user_mangas_configs.freezed.dart';
part 'change_user_mangas_configs.g.dart';

@freezed
class ChangeUserMangasConfigs with _$ChangeUserMangasConfigs {
  factory ChangeUserMangasConfigs({
    ReadingModeTypeEnum? readingMode,
    NSFWBehaviourEnum? nsfwBehaviour,
    TranslationLanguageEnum? translationLanguage,
    bool? skipChapterToAnotherTranslation,
    bool? showProgressForChaptersWithDecimals,
  }) = _ChangeUserMangasConfigs;

  factory ChangeUserMangasConfigs.fromJson(Map<String, dynamic> json) =>
      _$ChangeUserMangasConfigsFromJson(json);
}
