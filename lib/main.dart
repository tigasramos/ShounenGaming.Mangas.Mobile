import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

class SGMangasApp extends StatefulWidget {
  const SGMangasApp({super.key});

  @override
  State<SGMangasApp> createState() => _SGMangasAppState();
}

class _SGMangasAppState extends State<SGMangasApp> {
  PersistentTabController? controller;
  @override
  void initState() {
    controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SG Mangas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
            brightness: Brightness.dark),
        home: Scaffold(
          body: PersistentTabView(
            context,
            controller: controller,
            screens: const [
              SafeArea(
                  child: Scaffold(
                body: Text('Home'),
              )),
              SafeArea(child: Scaffold(body: Text('Library'))),
              SafeArea(child: Scaffold(body: Text('Search'))),
              SafeArea(child: Scaffold(body: Text('History'))),
              SafeArea(child: Scaffold(body: Text('Settings'))),
            ],
            items: [
              PersistentBottomNavBarItem(
                icon: const Icon(Icons.home),
                title: ("Home"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
              ),
              PersistentBottomNavBarItem(
                icon: const Icon(Icons.menu_book),
                title: ("Library"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
              ),
              PersistentBottomNavBarItem(
                icon: const Icon(Icons.search),
                title: ("Search"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
              ),
              PersistentBottomNavBarItem(
                icon: const Icon(Icons.history),
                title: ("History"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
              ),
              PersistentBottomNavBarItem(
                icon: const Icon(Icons.settings),
                title: ("Settings"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
              ),
            ],
            confineInSafeArea: true,
            backgroundColor: Theme.of(context).cardColor,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: const NavBarDecoration(
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
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
        ));
  }
}

final dioProvider = Provider<Dio>(
    (ref) => Dio(BaseOptions(baseUrl: 'https://localhost:7252/api/')));
