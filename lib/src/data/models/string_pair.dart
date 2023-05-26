// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StringPair {
  String id;
  String value;
  StringPair({
    required this.id,
    required this.value,
  });

  StringPair copyWith({
    String? id,
    String? value,
  }) {
    return StringPair(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
    };
  }

  factory StringPair.fromMap(Map<String, dynamic> map) {
    return StringPair(
      id: map['id'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StringPair.fromJson(String source) =>
      StringPair.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Pair(id: $id, value: $value)';

  @override
  bool operator ==(covariant StringPair other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}
