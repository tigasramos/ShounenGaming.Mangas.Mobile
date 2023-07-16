// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SearchMangaQuery {
  String? name;
  SearchMangaQuery({
    this.name,
  });

  SearchMangaQuery copyWith({
    String? name,
  }) {
    return SearchMangaQuery(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory SearchMangaQuery.fromMap(Map<String, dynamic> map) {
    return SearchMangaQuery(
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchMangaQuery.fromJson(String source) =>
      SearchMangaQuery.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SerachMangaQuery(name: $name)';

  @override
  bool operator ==(covariant SearchMangaQuery other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
