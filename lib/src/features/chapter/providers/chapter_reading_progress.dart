import 'dart:convert';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';

class ChapterReadingProgress {
  int chapterId;
  TranslationLanguageEnum language;
  int page;
  ChapterReadingProgress({
    required this.chapterId,
    required this.language,
    required this.page,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chapterId': chapterId,
      'language': language.name,
      'page': page,
    };
  }

  factory ChapterReadingProgress.fromMap(Map<String, dynamic> map) {
    return ChapterReadingProgress(
      chapterId: map['chapterId'] as int,
      language: TranslationLanguageEnum.values.byName(map['language']),
      page: map['page'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterReadingProgress.fromJson(String source) =>
      ChapterReadingProgress.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
