import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/auth_response.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/auth_repository.dart';

Future updateStoreAndState(Ref ref, AuthResponse authResponse) async {
  // Save in Local Storage
  await ref
      .watch(sharedPreferencesProvider)
      .setString("sg_mangas_refreshToken", authResponse.refreshToken);
  await ref
      .watch(sharedPreferencesProvider)
      .setString("sg_mangas_accessToken", authResponse.accessToken);

  // Update Interceptors
  var client = ref.watch(dioProvider);
  var authRepo = ref.read(authRepositoryProvider);
  client.interceptors.clear();
  client.interceptors.add(InterceptorsWrapper(
    onError: (error, handler) async {
      if (error.response?.statusCode != 401 &&
          error.response?.statusCode != 403) return handler.next(error);

      var sharedPreferences = ref.watch(sharedPreferencesProvider);
      await sharedPreferences.reload();
      var token = sharedPreferences.getString("sg_mangas_refreshToken");
      if (token != null) {
        print('Will Refresh Token');
        var authResponse = await authRepo.refreshToken(token);
        if (authResponse != null) {
          // Save in Local Storage
          await sharedPreferences.setString(
              "sg_mangas_refreshToken", authResponse.refreshToken);
          await sharedPreferences.setString(
              "sg_mangas_accessToken", authResponse.accessToken);

          print('New Tokens:');
          print('Access: ${authResponse.accessToken}');
          print('RefreshToken: ${authResponse.refreshToken}');
          try {
            var headers = error.requestOptions.headers;

            headers.remove('Authorization');
            var response = await Dio(client.options).request(
              error.requestOptions.path,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters,
              options: Options(
                method: error.requestOptions.method,
                headers: headers
                  ..putIfAbsent(
                    "Authorization",
                    () => "Bearer ${authResponse.accessToken}",
                  ),
              ),
            );
            if (response.statusCode == 200) {
              return handler.resolve(response);
            }
          } on Exception {
            ref.watch(appStateProvider.notifier).logout();
          }
        }
      }

      return handler.next(error);
    },
    onRequest: (options, handler) {
      var sharedPreferences = ref.watch(sharedPreferencesProvider);
      var token =
          sharedPreferences.getString("sg_mangas_accessToken")?.toString();

      print('Sending Token:${token ?? ""}');
      // Add Auth Token to Header
      if (token != null) {
        options.headers.putIfAbsent("Authorization", () => "Bearer $token");
      }

      return handler.next(options);
    },
  ));

  await ref.watch(appStateProvider.notifier).updateUser();
}
