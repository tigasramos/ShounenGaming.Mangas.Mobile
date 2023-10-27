import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/auth/screens/login_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import 'app_state.providers.dart';
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
          builder: (context, widget) {
            Widget error = const Text('...rendering error...');
            if (widget is Scaffold || widget is Navigator) {
              error = Scaffold(body: Center(child: error));
            }
            ErrorWidget.builder = (errorDetails) => error;
            if (widget != null) return widget;
            throw ('widget is null');
          },
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
