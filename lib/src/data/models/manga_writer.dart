import 'dart:convert';

class MangaWriter {
  int id;
  String name;
  MangaWriter({
    required this.id,
    required this.name,
  });

  MangaWriter copyWith({
    int? id,
    String? name,
  }) {
    return MangaWriter(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory MangaWriter.fromMap(Map<String, dynamic> map) {
    return MangaWriter(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaWriter.fromJson(String source) =>
      MangaWriter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MangaWriter(id: $id, name: $name)';

  @override
  bool operator ==(covariant MangaWriter other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
