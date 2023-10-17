import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/auth_repository.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/auth_helper.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';

import 'login_state.dart';

class LoginStateController extends StateNotifier<LoginState> {
  LoginStateController(this.ref) : super(LoginState()) {
    usernameController.text =
        ref.read(sharedPreferencesProvider).getString(localStorageUsername) ??
            "";
  }
  Ref ref;

  final usernameController = TextEditingController();
  final tokenController = TextEditingController();

  void changeRememberUsername(bool? rememberUsername) {
    state = state.copyWith(rememberUsername: rememberUsername);
  }

  Future createToken() async {
    state = state.copyWith(isCreatingToken: true);
    try {
      await ref
          .read(authRepositoryProvider)
          .createLoginToken(usernameController.text.trim());
      state = state.copyWith(isTokenGenerated: true);
    } on DioError catch (e) {
      var message = e.response?.data['Message'];
      snackbarKey.currentState?.showSnackBar(SnackBar(
        content: Text(
          'Error: $message',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[400],
        duration: const Duration(seconds: 3),
      ));
    }

    state = state.copyWith(isCreatingToken: false);
  }

  Future<bool> login() async {
    bool logged = false;
    state = state.copyWith(isLoggingIn: true);
    try {
      var authResponse = await ref
          .read(authRepositoryProvider)
          .login(usernameController.text.trim(), tokenController.text.trim());
      if (authResponse == null) throw Exception("Error Logging In");

      // Save in Local Storage
      await ref
          .read(sharedPreferencesProvider)
          .setString(localStorageRefreshTokenKey, authResponse.refreshToken);
      await ref
          .read(sharedPreferencesProvider)
          .setString(localStorageAccessTokenKey, authResponse.accessToken);

      await updateStoreAndState(ref);

      await ref
          .read(sharedPreferencesProvider)
          .setString(localStorageUsername, usernameController.text.trim());
      logged = true;
    } on DioError catch (e) {
      var message = e.response?.data['Message'];
      snackbarKey.currentState?.showSnackBar(SnackBar(
        content: Text(
          'Error: $message',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[400],
        duration: const Duration(seconds: 3),
      ));
    }
    state = state.copyWith(isLoggingIn: false);
    return logged;
  }
}
