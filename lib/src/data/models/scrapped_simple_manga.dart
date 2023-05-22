import 'dart:convert';

import 'enums/manga_source_enum.dart';

class ScrappedSimpleManga {
  String name;
  String link;
  String? imageUrl;
  MangaSourceEnum source;
  ScrappedSimpleManga({
    required this.name,
    required this.link,
    this.imageUrl,
    required this.source,
  });

  ScrappedSimpleManga copyWith({
    String? name,
    String? link,
    String? imageUrl,
    MangaSourceEnum? source,
  }) {
    return ScrappedSimpleManga(
      name: name ?? this.name,
      link: link ?? this.link,
      imageUrl: imageUrl ?? this.imageUrl,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'link': link,
      'imageUrl': imageUrl,
      'source': source.name,
    };
  }

  factory ScrappedSimpleManga.fromMap(Map<String, dynamic> map) {
    return ScrappedSimpleManga(
      name: map['name'] as String,
      link: map['link'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      source: MangaSourceEnum.values.byName(map['source']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ScrappedSimpleManga.fromJson(String source) =>
      ScrappedSimpleManga.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScrappedSimpleManga(name: $name, link: $link, imageUrl: $imageUrl, source: $source)';
  }

  @override
  bool operator ==(covariant ScrappedSimpleManga other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.link == link &&
        other.imageUrl == imageUrl &&
        other.source == source;
  }

  @override
  int get hashCode {
    return name.hashCode ^ link.hashCode ^ imageUrl.hashCode ^ source.hashCode;
  }
}
