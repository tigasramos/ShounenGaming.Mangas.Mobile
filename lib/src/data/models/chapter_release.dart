import 'dart:convert';

class ChapterRelease {
  String name;
  ChapterRelease({
    required this.name,
  });

  ChapterRelease copyWith({
    String? name,
  }) {
    return ChapterRelease(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory ChapterRelease.fromMap(Map<String, dynamic> map) {
    return ChapterRelease(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterRelease.fromJson(String source) =>
      ChapterRelease.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChapterRelease(name: $name)';

  @override
  bool operator ==(covariant ChapterRelease other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
