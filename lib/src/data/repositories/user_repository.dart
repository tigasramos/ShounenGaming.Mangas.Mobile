import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/change_user_mangas_configs.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/simple_user.dart';

import '../models/user.dart';
import '../models/user_mangas_configs.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return UserRepository(dio);
});

class UserRepository {
  final Dio _client;
  static const String _baseURL = "api/users";

  UserRepository(this._client);

  Future<User> getLoggedUser() async {
    var response = await _client.get('$_baseURL/me');
    return User.fromJson(response.data);
  }

  Future<User> getUserById(int id) async {
    var response = await _client.get('$_baseURL/$id');
    return User.fromJson(response.data);
  }

  Future<List<SimpleUser>> getAllUsers() async {
    var response = await _client.get('$_baseURL');
    return (response.data as List).map((m) => SimpleUser.fromJson(m)).toList();
  }

  Future<UserMangasConfigs> getUserConfigsForMangas() async {
    var response = await _client.get('$_baseURL/configs/mangas');
    return UserMangasConfigs.fromJson(response.data);
  }

  Future<UserMangasConfigs> updateUserConfigsForMangas(
      ChangeUserMangasConfigs updatedConfigs) async {
    var response = await _client.put('$_baseURL/configs/mangas',
        data: updatedConfigs.toJson(),
        options: Options(contentType: 'application/json'));
    return UserMangasConfigs.fromJson(response.data);
  }
}
