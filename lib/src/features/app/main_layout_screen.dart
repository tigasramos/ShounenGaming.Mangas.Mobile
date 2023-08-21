import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/home_providers.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/home_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_status_screens/library_reading_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/search/manga_search_provider.dart';
import 'package:shounengaming_mangas_mobile/src/features/search/search_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/settings/menu_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';
import 'package:shounengaming_mangas_mobile/src/others/menu_items.dart';

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
