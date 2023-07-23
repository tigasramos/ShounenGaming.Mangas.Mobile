// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_source_enum.dart';

class QueueProgress {
  double percentage;
  MangaSourceEnum currentSource;
  int currentChapter;
  int totalChapters;
  QueueProgress({
    required this.percentage,
    required this.currentSource,
    required this.currentChapter,
    required this.totalChapters,
  });

  QueueProgress copyWith({
    double? percentage,
    MangaSourceEnum? currentSource,
    int? currentChapter,
    int? totalChapters,
  }) {
    return QueueProgress(
      percentage: percentage ?? this.percentage,
      currentSource: currentSource ?? this.currentSource,
      currentChapter: currentChapter ?? this.currentChapter,
      totalChapters: totalChapters ?? this.totalChapters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'percentage': percentage,
      'currentSource': currentSource.name,
      'currentChapter': currentChapter,
      'totalChapters': totalChapters,
    };
  }

  factory QueueProgress.fromMap(Map<String, dynamic> map) {
    return QueueProgress(
      percentage: double.parse(map['percentage'].toString()),
      currentSource: MangaSourceEnum.values.byName(map['currentSource']),
      currentChapter: map['currentChapter'] as int,
      totalChapters: map['totalChapters'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory QueueProgress.fromJson(String source) =>
      QueueProgress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QueueProgress(percentage: $percentage, currentSource: $currentSource, currentChapter: $currentChapter, totalChapters: $totalChapters)';
  }

  @override
  bool operator ==(covariant QueueProgress other) {
    if (identical(this, other)) return true;

    return other.percentage == percentage &&
        other.currentSource == currentSource &&
        other.currentChapter == currentChapter &&
        other.totalChapters == totalChapters;
  }

  @override
  int get hashCode {
    return percentage.hashCode ^
        currentSource.hashCode ^
        currentChapter.hashCode ^
        totalChapters.hashCode;
  }
}
