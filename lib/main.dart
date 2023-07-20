// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/user.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/user_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/auth/login_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/featured_mangas_section.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/home_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/latest_releases_section.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/popular_mangas_section.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_status_screens/library_reading_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/search/search_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/settings/settings_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/auth_helper.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';
import 'package:shounengaming_mangas_mobile/src/others/menu_items.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: const SGMangasApp(),
  ));
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final navigationKey = GlobalKey<NavigatorState>();
final snackbarKey = GlobalKey<ScaffoldMessengerState>();

final appStateProvider = StateNotifierProvider<AppStateController, AppState>(
    (ref) => AppStateController(ref));

class AppState {
  User? loggedUser;

  bool loadingAuth;

  AppState({
    this.loggedUser,
    this.loadingAuth = false,
  });

  AppState copyWith({
    User? loggedUser,
    bool? loadingAuth,
  }) {
    return AppState(
      loggedUser: loggedUser ?? this.loggedUser,
      loadingAuth: loadingAuth ?? this.loadingAuth,
    );
  }

  AppState resetUser({
    bool? loadingAuth,
  }) {
    return AppState(
      loggedUser: null,
      loadingAuth: loadingAuth ?? this.loadingAuth,
    );
  }
}

class AppStateController extends StateNotifier<AppState> {
  AppStateController(this.ref) : super(AppState()) {
    getAuthState();
  }

  Ref ref;

  Future getAuthState() async {
    state = state.copyWith(loadingAuth: true);
    await updateStoreAndState(ref);
    state = state.copyWith(loadingAuth: false);
  }

  Future updateUser() async {
    try {
      var user = await ref.read(userRepositoryProvider).getLoggedUser();
      state = state.copyWith(loggedUser: user);
    } catch (e) {}
  }

  Future logout() async {
    var sharedPreferences = ref.watch(sharedPreferencesProvider);
    await sharedPreferences.remove(localStorageAccessTokenKey);
    await sharedPreferences.remove(localStorageRefreshTokenKey);

    navigationKey.currentState?.popUntil((route) => route.isFirst);
    state = state.resetUser();
  }
}

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

class MainLayoutScreen extends ConsumerStatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  ConsumerState<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends ConsumerState<MainLayoutScreen> {
  PersistentTabController? controller;
  @override
  void initState() {
    controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo-bg.png', height: 35),
            const SizedBox(
              width: 10,
            ),
            const Text('SG Mangas'),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                navigationKey.currentState?.push(
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
              icon: const Icon(Icons.settings)),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: PersistentTabView(
        context,
        controller: controller,
        onItemSelected: (i) {
          //TODO: Refresh providers state
          switch (i) {
            case 0:
              ref.invalidate(featuredMangasProvider);
              ref.invalidate(popularMangasProvider);
              ref.invalidate(newChaptersProvider);
              break;
            case 1:
              ref.invalidate(readingMangasProvider);
              break;
            case 2:
              ref.invalidate(mangaSearchProvider);
              break;
            case 3:
              break;
            case 4:
              break;
          }
          setState(() {});
        },
        screens: const [
          HomeScreen(),
          LibraryScreen(),
          SearchScreen(),
          Scaffold(
              body: Center(
            child: Text('In Construction'),
          )),
          Scaffold(
              body: Center(
            child: Text('In Construction'),
          )),
        ],
        items: menuItems
            .map(
              (e) => PersistentBottomNavBarItem(
                icon: Icon(e.icon),
                title: (e.name),
                activeColorPrimary: Theme.of(context).primaryColor,
                inactiveColorPrimary: Colors.grey,
              ),
            )
            .toList(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).cardColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: false,
        popAllScreensOnTapAnyTabs: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(),
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style9,
      ),
    );
  }
}

final dioProvider = Provider<Dio>((ref) {
  // LOCAL
  //final dio = Dio(BaseOptions(baseUrl: 'https://localhost:7252/'));

  // DEV
  //final dio =
  //    Dio(BaseOptions(baseUrl: 'https://server-dev.shounengaming.xyz/'));

  // PROD
  final dio = Dio(BaseOptions(baseUrl: 'https://server.shounengaming.xyz/'));

  ref.onDispose(dio.close);

  return dio;
});
