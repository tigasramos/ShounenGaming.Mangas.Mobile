// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'enums/roles_enum.dart';

class User {
  int id;
  String fullName;
  String discordId;
  String discordImage;
  String username;
  DateTime birthday;
  RolesEnum role;
  User({
    required this.id,
    required this.fullName,
    required this.discordId,
    required this.discordImage,
    required this.username,
    required this.birthday,
    required this.role,
  });

  User copyWith({
    int? id,
    String? fullName,
    String? discordId,
    String? discordImage,
    String? username,
    DateTime? birthday,
    RolesEnum? role,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      discordId: discordId ?? this.discordId,
      discordImage: discordImage ?? this.discordImage,
      username: username ?? this.username,
      birthday: birthday ?? this.birthday,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'discordId': discordId,
      'discordImage': discordImage,
      'username': username,
      'birthday': birthday.toString(),
      'role': role.name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      fullName: map['fullName'] as String,
      discordId: map['discordId'] as String,
      discordImage: map['discordImage'] as String,
      username: map['username'] as String,
      birthday: DateTime.parse(map['birthday']),
      role: RolesEnum.values.byName(map['role']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, discordId: $discordId, discordImage: $discordImage, username: $username, role: $role, birthday: $birthday)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.discordId == discordId &&
        other.discordImage == discordImage &&
        other.username == username &&
        other.role == role &&
        other.birthday == birthday;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        discordId.hashCode ^
        discordImage.hashCode ^
        username.hashCode ^
        role.hashCode ^
        birthday.hashCode;
  }
}
