import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:shounengaming_mangas_mobile/src/features/app/more_options_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/user_profile/screens/user_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/menu_items.dart';

import 'app_state.providers.dart';

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
          Consumer(builder: (context, ref, child) {
            var loggedUser = ref.watch(appStateProvider).loggedUser;
            if (loggedUser == null) return Container();
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: InkWell(
                onTap: () {
                  navigationKey.currentState?.push(MaterialPageRoute(
                    builder: (context) => UserProfileScreen(loggedUser.id),
                  ));
                },
                child: CircleAvatar(
                  backgroundImage:
                      CachedNetworkImageProvider(loggedUser.discordImage),
                  radius: 14,
                ),
              ),
            );
          }),
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
              ref.invalidate(newMangasProvider);
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
          MoreOptionsScreen()
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
