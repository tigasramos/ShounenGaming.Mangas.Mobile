import 'package:freezed_annotation/freezed_annotation.dart';

part 'simple_user.freezed.dart';
part 'simple_user.g.dart';

@freezed
class SimpleUser with _$SimpleUser {
  factory SimpleUser({
    required int id,
    required String fullName,
    required String username,
    String? discordImage,
  }) = _SimpleUser;

  factory SimpleUser.fromJson(Map<String, dynamic> json) =>
      _$SimpleUserFromJson(json);
}
