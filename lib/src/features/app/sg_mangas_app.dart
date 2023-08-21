import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/auth/login_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

import 'app_state_provider.dart';
import 'main_layout_screen.dart';

class SGMangasApp extends ConsumerWidget {
  const SGMangasApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appState = ref.watch(appStateProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
          title: 'SG Mangas',
          scaffoldMessengerKey: snackbarKey,
          debugShowCheckedModeBanner: false,
          theme: theme,
          navigatorKey: navigationKey,
          home: appState.loadingAuth
              ? const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : (appState.loggedUser != null
                  ? const MainLayoutScreen()
                  : const LoginScreen())),
    );
  }
}
