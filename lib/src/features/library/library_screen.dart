import 'package:flutter/material.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_status_screens/library_completed_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_status_screens/library_reading_screen.dart';

import 'library_status_screens/library_dropped_screen.dart';
import 'library_status_screens/library_ignored_screen.dart';
import 'library_status_screens/library_planning_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: MangaUserStatusEnum.values.length,
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                tabs: MangaUserStatusEnum.values
                    .map((e) => Tab(
                          text: e.name,
                        ))
                    .toList()),
            const Expanded(
              child: TabBarView(children: [
                LibraryReadingScreen(),
                LibraryCompletedScreen(),
                LibraryPlanningScreen(),
                LibraryDroppedScreen(),
                LibraryIgnoredScreen(),
              ]),
            ),
          ],
        ));
  }
}
