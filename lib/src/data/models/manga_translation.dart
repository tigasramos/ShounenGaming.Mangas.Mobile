// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';

class MangaTranslation {
  TranslationLanguageEnum language;
  DateTime? releasedAt;
  DateTime createdAt;
  TranslationLanguageEnum defaultLanguage;
  int chapterId;
  String chapterNumber;
  String mangaName;
  int? previousChapterId;
  int? nextChapterId;
  String source;
  List<String> pages;
  Map<String, String>? pageHeaders;

  MangaTranslation({
    required this.language,
    this.releasedAt,
    required this.createdAt,
    required this.defaultLanguage,
    required this.chapterId,
    required this.chapterNumber,
    required this.mangaName,
    this.previousChapterId,
    this.nextChapterId,
    required this.source,
    required this.pages,
    this.pageHeaders,
  });

  MangaTranslation copyWith({
    TranslationLanguageEnum? language,
    DateTime? releasedAt,
    DateTime? createdAt,
    TranslationLanguageEnum? defaultLanguage,
    int? chapterId,
    String? chapterNumber,
    String? mangaName,
    int? previousChapterId,
    int? nextChapterId,
    List<String>? pages,
    String? source,
    Map<String, String>? pageHeaders,
  }) {
    return MangaTranslation(
        language: language ?? this.language,
        releasedAt: releasedAt ?? this.releasedAt,
        defaultLanguage: defaultLanguage ?? this.defaultLanguage,
        createdAt: createdAt ?? this.createdAt,
        chapterId: chapterId ?? this.chapterId,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        mangaName: mangaName ?? this.mangaName,
        previousChapterId: previousChapterId ?? this.previousChapterId,
        nextChapterId: nextChapterId ?? this.nextChapterId,
        pages: pages ?? this.pages,
        source: source ?? this.source,
        pageHeaders: pageHeaders ?? this.pageHeaders);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language.name,
      'defaultLanguage': defaultLanguage.name,
      'createdAt': createdAt.toString(),
      'releasedAt': releasedAt?.toString(),
      'chapterId': chapterId,
      'chapterNumber': chapterNumber,
      'mangaName': mangaName,
      'previousChapterId': previousChapterId,
      'nextChapterId': nextChapterId,
      'source': source,
      'pages': pages,
    };
  }

  factory MangaTranslation.fromMap(Map<String, dynamic> map) {
    return MangaTranslation(
      language: TranslationLanguageEnum.values.byName(map['language']),
      releasedAt: map['releasedDate'] != null
          ? DateTime.parse(map['releasedDate'])
          : null,
      createdAt: DateTime.parse(map['createdAt']),
      defaultLanguage:
          TranslationLanguageEnum.values.byName(map['defaultLanguage']),
      chapterId: map['chapterId'] as int,
      chapterNumber: map['chapterNumber'].toString(),
      mangaName: map['mangaName'] as String,
      previousChapterId: map['previousChapterId'] != null
          ? map['previousChapterId'] as int
          : null,
      nextChapterId:
          map['nextChapterId'] != null ? map['nextChapterId'] as int : null,
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
    return 'MangaTranslation(language: $language, releasedAt: $releasedAt, createdAt: $createdAt, defaultLanguage: $defaultLanguage source: $source, chapterId: $chapterId, chapterNumber: $chapterNumber, mangaName: $mangaName, previousChapterId: $previousChapterId, nextChapterId: $nextChapterId, pages: $pages)';
  }

  @override
  bool operator ==(covariant MangaTranslation other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.language == language &&
        other.releasedAt == releasedAt &&
        other.chapterId == chapterId &&
        other.defaultLanguage == defaultLanguage &&
        other.createdAt == createdAt &&
        other.chapterNumber == chapterNumber &&
        other.source == source &&
        other.mangaName == mangaName &&
        other.previousChapterId == previousChapterId &&
        other.nextChapterId == nextChapterId &&
        listEquals(other.pages, pages);
  }

  @override
  int get hashCode {
    return language.hashCode ^
        releasedAt.hashCode ^
        chapterId.hashCode ^
        chapterNumber.hashCode ^
        createdAt.hashCode ^
        defaultLanguage.hashCode ^
        source.hashCode ^
        mangaName.hashCode ^
        previousChapterId.hashCode ^
        nextChapterId.hashCode ^
        pages.hashCode;
  }
}
