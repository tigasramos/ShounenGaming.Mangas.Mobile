// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SimpleUser {
  int id;
  String fullName;
  String username;
  String? discordImage;
  SimpleUser({
    required this.id,
    required this.fullName,
    required this.username,
    this.discordImage,
  });

  SimpleUser copyWith({
    int? id,
    String? fullName,
    String? username,
    String? discordImage,
  }) {
    return SimpleUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      discordImage: discordImage ?? this.discordImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'username': username,
      'discordImage': discordImage,
    };
  }

  factory SimpleUser.fromMap(Map<String, dynamic> map) {
    return SimpleUser(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      username: map['username'] as String,
      discordImage:
          map['discordImage'] != null ? map['discordImage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SimpleUser.fromJson(String source) =>
      SimpleUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SimpleUser(id: $id, fullName: $fullName, username: $username, discordImage: $discordImage)';
  }

  @override
  bool operator ==(covariant SimpleUser other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.username == username &&
        other.discordImage == discordImage;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        username.hashCode ^
        discordImage.hashCode;
  }
}
