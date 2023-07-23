// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';

import 'package:shounengaming_mangas_mobile/src/data/repositories/auth_repository.dart';
import 'package:shounengaming_mangas_mobile/src/others/auth_helper.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

final loginStateProvider =
    StateNotifierProvider.autoDispose<LoginStateController, LoginState>(
        (ref) => LoginStateController(ref));

class LoginState {
  bool isTokenGenerated;
  bool rememberUsername;

  bool isCreatingToken;
  bool isLoggingIn;
  LoginState({
    this.isTokenGenerated = false,
    this.rememberUsername = true,
    this.isCreatingToken = false,
    this.isLoggingIn = false,
  });

  LoginState copyWith({
    bool? isTokenGenerated,
    bool? rememberUsername,
    bool? isCreatingToken,
    bool? isLoggingIn,
  }) {
    return LoginState(
      isTokenGenerated: isTokenGenerated ?? this.isTokenGenerated,
      isCreatingToken: isCreatingToken ?? this.isCreatingToken,
      rememberUsername: rememberUsername ?? this.rememberUsername,
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
    );
  }
}

final serverRunningProvider = FutureProvider<bool>((ref) async {
  final timer = Timer(
    const Duration(seconds: 5),
    () {
      ref.invalidateSelf();
    },
  );
  ref.onDispose(timer.cancel);

  var response = await ref.watch(dioProvider).get('healthz');
  return response.statusCode == 200 && response.data.toString() == "Healthy";
});

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

  Future login() async {
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
  }
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginState = ref.watch(loginStateProvider);
    var functions = ref.watch(loginStateProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('SG Mangas'),
        actions: [
          Tooltip(
            message: ref.watch(serverRunningProvider).when(
                  data: (data) => data ? 'Online' : 'Offline',
                  error: (error, stackTrace) => 'Error: $error $stackTrace',
                  loading: () => 'Validating',
                ),
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: ref.watch(serverRunningProvider).when(
                            data: (data) => data
                                ? [
                                    Colors.green,
                                    Colors.greenAccent,
                                  ]
                                : [
                                    Colors.red,
                                    Colors.redAccent,
                                  ],
                            error: (error, stackTrace) => [
                              Colors.red,
                              Colors.redAccent,
                            ],
                            loading: () => [
                              Colors.orange,
                              Colors.orangeAccent,
                            ],
                          )),
                  shape: BoxShape.circle),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            loginState.isLoggingIn
                ? const LinearProgressIndicator()
                : const SizedBox(
                    height: 4,
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  //const FlutterLogo(size: 80),
                  Image.asset(
                    'assets/images/logo-bg.png',
                    height: 120,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'Sign In to Continue',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: functions.usernameController,
                    style: const TextStyle(fontSize: 14),
                    onEditingComplete: () => functions.createToken(),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: InkWell(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await functions.createToken();
                        },
                        child: loginState.isCreatingToken
                            ? const Padding(
                                padding: EdgeInsets.all(8),
                                child: CircularProgressIndicator())
                            : const Icon(
                                Icons.send,
                              ),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero)),
                      isDense: true,
                      hintText: 'Username',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: functions.tokenController,
                    enabled: loginState.isTokenGenerated,
                    onEditingComplete: () => functions.login(),
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero)),
                      isDense: true,
                      hintText: 'Token',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: loginState.rememberUsername,
                        onChanged: functions.changeRememberUsername,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Text('Remember Username'),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: MaterialButton(
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          await functions.login();
                        },
                        minWidth: double.infinity,
                        color: palette[1],
                        child: const Text('Login')),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
