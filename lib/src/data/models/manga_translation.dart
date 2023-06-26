// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';

class MangaTranslation {
  TranslationLanguageEnum language;
  DateTime? releasedDate;
  int chapterId;
  double chapterNumber;
  String mangaName;
  int? previousChapterTranslationId;
  int? nextChapterTranslationId;
  String source;
  List<String> pages;
  Map<String, String>? pageHeaders;

  MangaTranslation({
    required this.language,
    this.releasedDate,
    required this.chapterId,
    required this.chapterNumber,
    required this.mangaName,
    this.previousChapterTranslationId,
    this.nextChapterTranslationId,
    required this.source,
    required this.pages,
    this.pageHeaders,
  });

  MangaTranslation copyWith({
    TranslationLanguageEnum? language,
    DateTime? releasedDate,
    int? chapterId,
    double? chapterNumber,
    String? mangaName,
    int? previousChapterTranslationId,
    int? nextChapterTranslationId,
    List<String>? pages,
    String? source,
    Map<String, String>? pageHeaders,
  }) {
    return MangaTranslation(
        language: language ?? this.language,
        releasedDate: releasedDate ?? this.releasedDate,
        chapterId: chapterId ?? this.chapterId,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        mangaName: mangaName ?? this.mangaName,
        previousChapterTranslationId:
            previousChapterTranslationId ?? this.previousChapterTranslationId,
        nextChapterTranslationId:
            nextChapterTranslationId ?? this.nextChapterTranslationId,
        pages: pages ?? this.pages,
        source: source ?? this.source,
        pageHeaders: pageHeaders ?? this.pageHeaders);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language.name,
      'releasedDate': releasedDate?.toString(),
      'chapterId': chapterId,
      'chapterNumber': chapterNumber,
      'mangaName': mangaName,
      'previousChapterTranslationId': previousChapterTranslationId,
      'nextChapterTranslationId': nextChapterTranslationId,
      'source': source,
      'pages': pages,
    };
  }

  factory MangaTranslation.fromMap(Map<String, dynamic> map) {
    return MangaTranslation(
      language: TranslationLanguageEnum.values.byName(map['language']),
      releasedDate: map['releasedDate'] != null
          ? DateTime.parse(map['releasedDate'])
          : null,
      chapterId: map['chapterId'] as int,
      chapterNumber: map['chapterNumber'] is String
          ? double.parse(map['chapterNumber'])
          : map['chapterNumber'].toDouble(),
      mangaName: map['mangaName'] as String,
      previousChapterTranslationId: map['previousChapterTranslationId'] != null
          ? map['previousChapterTranslationId'] as int
          : null,
      nextChapterTranslationId: map['nextChapterTranslationId'] != null
          ? map['nextChapterTranslationId'] as int
          : null,
      pages: List<String>.from(map['pages']),
      source: map['source'] as String,
      pageHeaders: map['pageHeaders'] != null
          ? Map<String, String>.from(map['pageHeaders'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaTranslation.fromJson(String source) =>
      MangaTranslation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MangaTranslation(language: $language, releasedDate: $releasedDate, source: $source, chapterId: $chapterId, chapterNumber: $chapterNumber, mangaName: $mangaName, previousChapterTranslationId: $previousChapterTranslationId, nextChapterTranslationId: $nextChapterTranslationId, pages: $pages)';
  }

  @override
  bool operator ==(covariant MangaTranslation other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.language == language &&
        other.releasedDate == releasedDate &&
        other.chapterId == chapterId &&
        other.chapterNumber == chapterNumber &&
        other.source == source &&
        other.mangaName == mangaName &&
        other.previousChapterTranslationId == previousChapterTranslationId &&
        other.nextChapterTranslationId == nextChapterTranslationId &&
        listEquals(other.pages, pages);
  }

  @override
  int get hashCode {
    return language.hashCode ^
        releasedDate.hashCode ^
        chapterId.hashCode ^
        chapterNumber.hashCode ^
        source.hashCode ^
        mangaName.hashCode ^
        previousChapterTranslationId.hashCode ^
        nextChapterTranslationId.hashCode ^
        pages.hashCode;
  }
}
