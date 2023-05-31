// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';

class MangaTranslation {
  int id;
  TranslationLanguageEnum language;
  DateTime? releasedDate;
  int chapterId;
  String chapterNumber;
  String mangaName;
  int? previousChapterTranslationId;
  int? nextChapterTranslationId;
  List<String> pages;

  MangaTranslation({
    required this.id,
    required this.language,
    this.releasedDate,
    required this.chapterId,
    required this.chapterNumber,
    required this.mangaName,
    this.previousChapterTranslationId,
    this.nextChapterTranslationId,
    required this.pages,
  });

  MangaTranslation copyWith({
    int? id,
    TranslationLanguageEnum? language,
    DateTime? releasedDate,
    int? chapterId,
    String? chapterNumber,
    String? mangaName,
    int? previousChapterTranslationId,
    int? nextChapterTranslationId,
    List<String>? pages,
  }) {
    return MangaTranslation(
      id: id ?? this.id,
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'language': language.name,
      'releasedDate': releasedDate?.toString(),
      'chapterId': chapterId,
      'chapterNumber': chapterNumber,
      'mangaName': mangaName,
      'previousChapterTranslationId': previousChapterTranslationId,
      'nextChapterTranslationId': nextChapterTranslationId,
      'pages': pages,
    };
  }

  factory MangaTranslation.fromMap(Map<String, dynamic> map) {
    return MangaTranslation(
      id: map['id'] as int,
      language: TranslationLanguageEnum.values.byName(map['language']),
      releasedDate: map['releasedDate'] != null
          ? DateTime.parse(map['releasedDate'])
          : null,
      chapterId: map['chapterId'] as int,
      chapterNumber: map['chapterNumber'] as String,
      mangaName: map['mangaName'] as String,
      previousChapterTranslationId: map['previousChapterTranslationId'] != null
          ? map['previousChapterTranslationId'] as int
          : null,
      nextChapterTranslationId: map['nextChapterTranslationId'] != null
          ? map['nextChapterTranslationId'] as int
          : null,
      pages: List<String>.from(map['pages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaTranslation.fromJson(String source) =>
      MangaTranslation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MangaTranslation(id: $id, language: $language, releasedDate: $releasedDate, chapterId: $chapterId, chapterNumber: $chapterNumber, mangaName: $mangaName, previousChapterTranslationId: $previousChapterTranslationId, nextChapterTranslationId: $nextChapterTranslationId, pages: $pages)';
  }

  @override
  bool operator ==(covariant MangaTranslation other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.language == language &&
        other.releasedDate == releasedDate &&
        other.chapterId == chapterId &&
        other.chapterNumber == chapterNumber &&
        other.mangaName == mangaName &&
        other.previousChapterTranslationId == previousChapterTranslationId &&
        other.nextChapterTranslationId == nextChapterTranslationId &&
        listEquals(other.pages, pages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        language.hashCode ^
        releasedDate.hashCode ^
        chapterId.hashCode ^
        chapterNumber.hashCode ^
        mangaName.hashCode ^
        previousChapterTranslationId.hashCode ^
        nextChapterTranslationId.hashCode ^
        pages.hashCode;
  }
}
