import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/home_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/search/search_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/menu_items.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

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

class SGMangasApp extends StatelessWidget {
  const SGMangasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SG Mangas',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const MainLayoutScreen());
  }
}

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
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
        title: const Text('SG Mangas'),
      ),
      body: PersistentTabView(
        context,
        controller: controller,
        onItemSelected: (i) {
          setState(() {});
        },
        screens: const [
          HomeScreen(),
          Scaffold(body: Text('Library')),
          SearchScreen(),
          Scaffold(body: Text('History')),
          Scaffold(body: Text('Settings')),
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
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(),
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
    );
  }
}

final dioProvider = Provider<Dio>(
    (ref) => Dio(BaseOptions(baseUrl: 'https://localhost:7252/api/')));
