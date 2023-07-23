// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_type_enum.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';

class MangaTranslation {
  TranslationLanguageEnum language;
  DateTime? releasedAt;
  DateTime createdAt;
  int chapterId;
  String chapterNumber;
  String mangaName;
  MangaTypeEnum mangaType;
  int? previousChapterId;
  int? nextChapterId;
  String source;
  List<String> pages;
  Map<String, String>? pageHeaders;

  MangaTranslation({
    required this.language,
    this.releasedAt,
    required this.createdAt,
    required this.chapterId,
    required this.chapterNumber,
    required this.mangaName,
    required this.mangaType,
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
    int? chapterId,
    String? chapterNumber,
    String? mangaName,
    MangaTypeEnum? mangaType,
    int? previousChapterId,
    int? nextChapterId,
    List<String>? pages,
    String? source,
    Map<String, String>? pageHeaders,
  }) {
    return MangaTranslation(
        language: language ?? this.language,
        releasedAt: releasedAt ?? this.releasedAt,
        createdAt: createdAt ?? this.createdAt,
        chapterId: chapterId ?? this.chapterId,
        chapterNumber: chapterNumber ?? this.chapterNumber,
        mangaName: mangaName ?? this.mangaName,
        mangaType: mangaType ?? this.mangaType,
        previousChapterId: previousChapterId ?? this.previousChapterId,
        nextChapterId: nextChapterId ?? this.nextChapterId,
        pages: pages ?? this.pages,
        source: source ?? this.source,
        pageHeaders: pageHeaders ?? this.pageHeaders);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language.name,
      'createdAt': createdAt.toString(),
      'releasedAt': releasedAt?.toString(),
      'chapterId': chapterId,
      'chapterNumber': chapterNumber,
      'mangaName': mangaName,
      'mangaType': mangaType,
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
      chapterId: map['chapterId'] as int,
      chapterNumber: map['chapterNumber'].toString(),
      mangaName: map['mangaName'] as String,
      mangaType: MangaTypeEnum.values.byName(map['mangaType']),
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
    return 'MangaTranslation(language: $language, releasedAt: $releasedAt, createdAt: $createdAt, mangaType: $mangaType , source: $source, chapterId: $chapterId, chapterNumber: $chapterNumber, mangaName: $mangaName, previousChapterId: $previousChapterId, nextChapterId: $nextChapterId, pages: $pages)';
  }

  @override
  bool operator ==(covariant MangaTranslation other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.language == language &&
        other.releasedAt == releasedAt &&
        other.mangaType == mangaType &&
        other.chapterId == chapterId &&
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
        mangaType.hashCode ^
        chapterNumber.hashCode ^
        createdAt.hashCode ^
        source.hashCode ^
        mangaName.hashCode ^
        previousChapterId.hashCode ^
        nextChapterId.hashCode ^
        pages.hashCode;
  }
}
