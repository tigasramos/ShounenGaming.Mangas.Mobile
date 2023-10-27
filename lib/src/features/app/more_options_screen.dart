import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/roles_enum.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state.providers.dart';
import 'package:shounengaming_mangas_mobile/src/features/configurations/screens/configurations_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_add/screens/manga_add_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/mangas_queue/mangas_queue_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/season_mangas/screens/season_mangas_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/users_list/screens/users_list_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/waiting_mangas/screens/waiting_mangas_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

class MoreOptionsScreen extends ConsumerWidget {
  const MoreOptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appState = ref.watch(appStateProvider);
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'More Actions',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: MoreOptionsButtonTile(Icons.add, 'Add Manga',
                              (ctx) => AddMangaScreen(), "Add a New Manga")),
                      Expanded(
                        child: MoreOptionsButtonTile(
                            Icons.dynamic_feed,
                            'Mangas Queue',
                            (ctx) => const MangasQueueScreen(),
                            "Mangas currently being fetched"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: MoreOptionsButtonTile(
                              Icons.calendar_month,
                              'Season Mangas',
                              (context) => const SeasonMangasScreen(),
                              "Mangas from Animes being released")),
                      Expanded(
                        child: MoreOptionsButtonTile(
                            Icons.group,
                            'Users',
                            (context) => const UsersListScreen(),
                            "List of All SG Users"),
                      )
                    ],
                  ),
                  if (appState.loggedUser?.role != RolesEnum.USER) ...[
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MoreOptionsButtonTile(
                              Icons.checklist,
                              'Requested Mangas',
                              (context) => const WaitingMangasScreen(),
                              "Mangas Requested by the Users"),
                        )
                      ],
                    ),
                  ],
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MoreOptionsButtonTile(
                            Icons.settings,
                            'Configurations',
                            (context) => const ConfigurationsScreen(),
                            "User Configurations (Language & Behaviours)"),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () async {
                    ref.read(appStateProvider.notifier).logout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: const Text('Sign Out'),
                  )),
            ],
          )),
    );
  }
}

class MoreOptionsButtonTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Widget Function(BuildContext) builder;
  const MoreOptionsButtonTile(
      this.icon, this.title, this.builder, this.description,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(MaterialPageRoute(
          builder: builder,
        ));
      },
      child: Container(
        height: 75,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            //border: Border.all(color: palette[1]),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Icon(
              icon,
              color: palette[3],
              size: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: AutoSizeText(
                        title,
                        minFontSize: 12,
                        style: TextStyle(
                            color: Color.fromARGB(237, 255, 255, 255),
                            fontSize: 13),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      minFontSize: 8,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
