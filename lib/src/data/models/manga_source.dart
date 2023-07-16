// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_source_enum.dart';

class MangaSource {
  String name;
  MangaSourceEnum source;
  String url;
  String? imageURL;

  MangaSource({
    required this.name,
    required this.source,
    required this.url,
    this.imageURL,
  });

  MangaSource copyWith({
    String? name,
    MangaSourceEnum? source,
    String? url,
    String? imageURL,
  }) {
    return MangaSource(
      name: name ?? this.name,
      source: source ?? this.source,
      url: url ?? this.url,
      imageURL: imageURL ?? this.imageURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'source': source.name,
      'url': url,
      'imageURL': imageURL,
    };
  }

  factory MangaSource.fromMap(Map<String, dynamic> map) {
    return MangaSource(
      name: map['name'] as String,
      source: MangaSourceEnum.values.byName(map['source']),
      url: map['url'] as String,
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaSource.fromJson(String source) =>
      MangaSource.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MangaSource(name: $name, source: $source, url: $url, imageURL: $imageURL)';

  @override
  bool operator ==(covariant MangaSource other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.source == source &&
        other.url == url &&
        other.imageURL == imageURL;
  }

  @override
  int get hashCode =>
      name.hashCode ^ url.hashCode ^ source.hashCode ^ imageURL.hashCode;
}
