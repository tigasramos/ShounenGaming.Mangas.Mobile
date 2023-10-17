import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/roles_enum.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required int id,
    required String fullName,
    required String discordId,
    required String discordImage,
    required String username,
    required DateTime birthday,
    required RolesEnum role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
