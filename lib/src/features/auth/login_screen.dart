// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shounengaming_mangas_mobile/src/data/repositories/auth_repository.dart';
import 'package:shounengaming_mangas_mobile/src/others/auth_helper.dart';

final loginStateProvider =
    StateNotifierProvider<LoginStateController, LoginState>(
        (ref) => LoginStateController(ref));

class LoginState {
  String username;
  String? token;

  bool isTokenGenerated;

  bool isCreatingToken;
  bool isLoggingIn;
  LoginState({
    this.username = "",
    this.token,
    this.isTokenGenerated = false,
    this.isCreatingToken = false,
    this.isLoggingIn = false,
  });

  LoginState copyWith({
    String? username,
    String? token,
    bool? isTokenGenerated,
    bool? isCreatingToken,
    bool? isLoggingIn,
  }) {
    return LoginState(
      username: username ?? this.username,
      token: token ?? this.token,
      isTokenGenerated: isTokenGenerated ?? this.isTokenGenerated,
      isCreatingToken: isCreatingToken ?? this.isCreatingToken,
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
    );
  }
}

class LoginStateController extends StateNotifier<LoginState> {
  LoginStateController(this.ref) : super(LoginState());
  Ref ref;

  Future createToken() async {
    state = state.copyWith(isCreatingToken: true);
    try {
      await ref.read(authRepositoryProvider).createLoginToken('playerenergy');
      state = state.copyWith(isTokenGenerated: true);
    } on Exception {}

    state = state.copyWith(isCreatingToken: false);
  }

  Future login() async {
    state = state.copyWith(isLoggingIn: true);
    try {
      var authResponse = await ref
          .read(authRepositoryProvider)
          .login('playerenergy', state.token ?? "12345");

      await updateStoreAndState(ref, authResponse!);
    } on Exception {}
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
      appBar: AppBar(title: const Text('SG Mangas')),
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
                  const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      suffixIcon: InkWell(
                        onTap: () async {
                          await functions.createToken();
                        },
                        child: const Icon(
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
                    enabled: loginState.isTokenGenerated,
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
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          await functions.login();
                        },
                        child: const Text('Login')),
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
