// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/chapter_release.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';

class LatestReleaseManga {
  MangaInfo manga;
  Map<TranslationLanguageEnum, ChapterRelease> releasedChapters;
  LatestReleaseManga({
    required this.manga,
    required this.releasedChapters,
  });

  LatestReleaseManga copyWith({
    MangaInfo? manga,
    Map<TranslationLanguageEnum, ChapterRelease>? releasedChapters,
  }) {
    return LatestReleaseManga(
      manga: manga ?? this.manga,
      releasedChapters: releasedChapters ?? this.releasedChapters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'manga': manga.toMap(),
      'releasedChapters': releasedChapters,
    };
  }

  factory LatestReleaseManga.fromMap(Map<String, dynamic> map) {
    var dic = <TranslationLanguageEnum, ChapterRelease>{};
    (map['releasedChapters'] as Map).forEach((key, value) => dic.putIfAbsent(
        TranslationLanguageEnum.values.byName(key),
        () => ChapterRelease.fromMap(value)));
    return LatestReleaseManga(
        manga: MangaInfo.fromMap(map['manga'] as Map<String, dynamic>),
        releasedChapters: dic);
  }

  String toJson() => json.encode(toMap());

  factory LatestReleaseManga.fromJson(String source) =>
      LatestReleaseManga.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LatestReleaseManga(manga: $manga, releasedChapters: $releasedChapters)';

  @override
  bool operator ==(covariant LatestReleaseManga other) {
    if (identical(this, other)) return true;

    return other.manga == manga &&
        mapEquals(other.releasedChapters, releasedChapters);
  }

  @override
  int get hashCode => manga.hashCode ^ releasedChapters.hashCode;
}
