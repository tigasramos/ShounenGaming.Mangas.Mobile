import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/auth_response.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/auth_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state.providers.dart';

import 'constants.dart';

Future<bool> updateStoreAndState(Ref ref) async {
  var authResponse = await getTokens(ref);
  if (authResponse == null) {
    await ref.watch(appStateProvider.notifier).logout();
    return false;
  }

  // Update Interceptors
  var client = ref.watch(dioProvider);
  client.interceptors.clear();
  client.interceptors.add(QueuedInterceptorsWrapper(
    onError: (error, handler) async {
      if (error.response?.statusCode != 401 &&
          error.response?.statusCode != 403) return handler.next(error);
      var hasNewTokens = await updateStoreAndState(ref);
      if (hasNewTokens) {
        try {
          var headers = error.requestOptions.headers;

          headers.remove('Authorization');
          headers.putIfAbsent(
            "Authorization",
            () =>
                "Bearer ${ref.watch(sharedPreferencesProvider).getString(localStorageAccessTokenKey)}",
          );

          var response = await Dio(client.options).request(
            error.requestOptions.path,
            data: error.requestOptions.data,
            queryParameters: error.requestOptions.queryParameters,
            options: Options(
              method: error.requestOptions.method,
              headers: headers,
            ),
          );
          if (response.statusCode == 200) {
            return handler.resolve(response);
          }
        } on Exception {}
      }

      return handler.next(error);
    },
    onRequest: (options, handler) {
      // Add Auth Token to Header
      options.headers.putIfAbsent(
          "Authorization", () => "Bearer ${authResponse.accessToken}");

      return handler.next(options);
    },
  ));

  await ref.watch(appStateProvider.notifier).updateUser();
  return true;
}

Future<AuthResponse?> getTokens(Ref ref) async {
  var sharedPreferences = ref.watch(sharedPreferencesProvider);
  var authRepo = ref.read(authRepositoryProvider);

  var accessToken = sharedPreferences.getString(localStorageAccessTokenKey);
  var refreshToken = sharedPreferences.getString(localStorageRefreshTokenKey);
  var isExpired = accessToken == null
      ? true
      : JwtDecoder.getRemainingTime(accessToken) < const Duration(seconds: 10);

  // No Refresh Token = Logout
  if (refreshToken == null) return null;

  // If not expired = Return existing
  if (!isExpired) {
    return AuthResponse(accessToken: accessToken, refreshToken: refreshToken);
  }

  var authResponse = await authRepo.refreshToken(refreshToken);
  if (authResponse != null) {
    // Save in Local Storage
    await sharedPreferences.setString(
        localStorageRefreshTokenKey, authResponse.refreshToken);
    await sharedPreferences.setString(
        localStorageAccessTokenKey, authResponse.accessToken);

    return authResponse;
  }

  return null;
}
