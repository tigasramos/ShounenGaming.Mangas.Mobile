import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'manga.dart';

class PaginatedMangaResponse {
  List<Manga> data;
  int currentPage;
  int maxCount;
  PaginatedMangaResponse({
    required this.data,
    required this.currentPage,
    required this.maxCount,
  });

  PaginatedMangaResponse copyWith({
    List<Manga>? data,
    int? currentPage,
    int? maxCount,
  }) {
    return PaginatedMangaResponse(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      maxCount: maxCount ?? this.maxCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
      'currentPage': currentPage,
      'maxCount': maxCount,
    };
  }

  factory PaginatedMangaResponse.fromMap(Map<String, dynamic> map) {
    return PaginatedMangaResponse(
      data: List<Manga>.from(
        (map['data']).map<Manga>(
          (x) => Manga.fromMap(x as Map<String, dynamic>),
        ),
      ),
      currentPage: map['currentPage'] as int,
      maxCount: map['maxCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginatedMangaResponse.fromJson(String source) =>
      PaginatedMangaResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PaginatedMangaResponse(data: $data, currentPage: $currentPage, maxCount: $maxCount)';

  @override
  bool operator ==(covariant PaginatedMangaResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data) &&
        other.currentPage == currentPage &&
        other.maxCount == maxCount;
  }

  @override
  int get hashCode => data.hashCode ^ currentPage.hashCode ^ maxCount.hashCode;
}
