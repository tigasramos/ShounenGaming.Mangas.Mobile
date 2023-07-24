// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/user.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/user_mangas_configs.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/user_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/auth/login_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/featured_mangas_section.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/home_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/latest_releases_section.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/popular_mangas_section.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_status_screens/library_reading_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/search/search_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/settings/menu_screen.dart';
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

  PlatformDispatcher.instance.onError = (error, stack) {
    Sentry.captureException(
      error,
      stackTrace: stack,
    );
    return true;
  };

  FlutterError.onError = (details) async {
    FlutterError.presentError(details);
    await Sentry.captureException(
      details,
      stackTrace: details.stack,
    );
    if (kReleaseMode) exit(1);
  };

  final sharedPreferences = await SharedPreferences.getInstance();

  await SentryFlutter.init(
    (options) {
      options.dsn = "";
      options.tracesSampleRate = 1.0;

      // TODO: Update with every Release
      options.release = "1.1.1";
    },
    appRunner: () => runApp(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const SGMangasApp(),
    )),
  );
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
  UserMangasConfigs? userConfigs;

  bool loadingAuth;

  AppState({
    this.loggedUser,
    this.userConfigs,
    this.loadingAuth = false,
  });

  AppState copyWith({
    User? loggedUser,
    UserMangasConfigs? userConfigs,
    bool? loadingAuth,
  }) {
    return AppState(
      loggedUser: loggedUser ?? this.loggedUser,
      userConfigs: userConfigs ?? this.userConfigs,
      loadingAuth: loadingAuth ?? this.loadingAuth,
    );
  }

  AppState resetUser() {
    return AppState(
      loggedUser: null,
      userConfigs: null,
      loadingAuth: false,
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
      var usersRepo = ref.read(userRepositoryProvider);
      var user = await usersRepo.getLoggedUser();
      var userConfigs = await usersRepo.getUserConfigsForMangas();
      state = state.copyWith(loggedUser: user, userConfigs: userConfigs);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void setNewConfigs(UserMangasConfigs configs) {
    state = state.copyWith(userConfigs: configs);
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
                  MaterialPageRoute(builder: (context) => const MenuScreen()),
                );
              },
              icon: const Icon(Icons.menu)),
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

final serverUrlProvider = StateProvider((ref) {
  //return 'https://localhost:7252/';
  //return 'https://server-dev.shounengaming.xyz/';
  return 'https://server.shounengaming.xyz/';
});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: ref.watch(serverUrlProvider)));

  ref.onDispose(dio.close);

  return dio;
});
