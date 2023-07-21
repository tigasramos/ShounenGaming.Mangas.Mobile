import 'package:flutter/material.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_status_screens/library_completed_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_status_screens/library_reading_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/library_status_screens/library_waiting_screen.dart';

import 'library_status_screens/library_dropped_screen.dart';
import 'library_status_screens/library_ignored_screen.dart';
import 'library_status_screens/library_onhold_screen.dart';
import 'library_status_screens/library_planning_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Column(
          children: [
            TabBar(
              isScrollable: true,
              tabs: [
                'Reading',
                'Waiting',
                'Paused',
                'Completed',
                'Planning',
                'Dropped',
                'Ignored'
              ].map((e) => Tab(text: e)).toList(),
            ),
            const Expanded(
              child: TabBarView(children: [
                LibraryReadingScreen(),
                LibraryWaitingScreen(),
                LibraryOnHoldScreen(),
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
