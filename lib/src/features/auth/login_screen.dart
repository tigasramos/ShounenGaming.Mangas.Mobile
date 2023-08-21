// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

import 'login_provider.dart';

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
