import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/change_user_mangas_configs.dart';

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
    return User.fromMap(response.data);
  }

  Future<User> getUserById(int id) async {
    var response = await _client.get('$_baseURL/$id');
    return User.fromMap(response.data);
  }

  Future<UserMangasConfigs> getUserConfigsForMangas() async {
    var response = await _client.get('$_baseURL/configs/mangas');
    return UserMangasConfigs.fromMap(response.data);
  }

  Future<UserMangasConfigs> updateUserConfigsForMangas(
      ChangeUserMangasConfigs updatedConfigs) async {
    var response = await _client.put('$_baseURL/configs/mangas',
        data: updatedConfigs.toMap());
    return UserMangasConfigs.fromMap(response.data);
  }
}
