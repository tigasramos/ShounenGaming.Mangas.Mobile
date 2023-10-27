import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/translation_language_enum.dart';

part 'manga_translation_info.freezed.dart';
part 'manga_translation_info.g.dart';

@freezed
class MangaTranslationInfo with _$MangaTranslationInfo {
  factory MangaTranslationInfo({
    required int id,
    required TranslationLanguageEnum language,
    required DateTime createdAt,
  }) = _MangaTranslationInfo;

  factory MangaTranslationInfo.fromJson(Map<String, dynamic> json) =>
      _$MangaTranslationInfoFromJson(json);
}
