import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';

import '../models/user.dart';

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
}
