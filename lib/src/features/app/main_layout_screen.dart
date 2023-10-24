import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shounengaming_mangas_mobile/src/features/community/providers/community.providers.dart';
import 'package:shounengaming_mangas_mobile/src/features/community/screens/community_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/providers/home.providers.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/screens/home_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/providers/library.providers.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/screens/library_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/mangas_search/providers/manga_search.providers.dart';
import 'package:shounengaming_mangas_mobile/src/features/mangas_search/screens/search_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/menu_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/menu_items.dart';

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
              ref.invalidate(mangaRecommendationsProvider);
              ref.invalidate(communityActivitiesProvider);
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
          CommunityScreen(),
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
