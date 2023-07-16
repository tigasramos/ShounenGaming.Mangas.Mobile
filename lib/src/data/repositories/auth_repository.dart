import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';

import '../models/auth_response.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio, ref);
});

class AuthRepository {
  final Dio _client;
  final Ref ref;
  static const String _baseURL = "api/auth";

  AuthRepository(this._client, this.ref);

  Future createLoginToken(String username) async {
    await _client.post('$_baseURL/user/token?username=$username');
  }

  Future<AuthResponse?> login(String username, String token) async {
    var response = await _client
        .get('$_baseURL/user/login?username=$username&token=$token');
    if (response.statusCode == 200) {
      var authResponse = AuthResponse.fromMap(response.data);

      return authResponse;
    }

    return null;
  }

  Future<AuthResponse?> refreshToken(String token) async {
    try {
      var response = await _client.get('$_baseURL/refreshToken',
          options: Options(headers: {'refreshToken': token}));

      var authResponse = AuthResponse.fromMap(response.data);
      return authResponse;
    } on Exception {
      return null;
    }
  }
}
