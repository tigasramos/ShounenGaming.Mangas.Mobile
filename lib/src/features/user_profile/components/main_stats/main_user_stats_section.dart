import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/user_manga_main_stats.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

class MainUserStatsSection extends StatelessWidget {
  final UserMangaMainStats mainStats;
  const MainUserStatsSection(this.mainStats, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Consumer(
                  builder: (context, ref, child) => Text(
                        "${mainStats.numOfMangas}",
                        style: TextStyle(color: palette[2], fontSize: 18),
                      )),
              Text(
                'Total Mangas',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.55), fontSize: 13),
              )
            ],
          ),
          Column(
            children: [
              Consumer(
                  builder: (context, ref, child) => Text(
                        "${mainStats.numOfChapters}",
                        style: TextStyle(color: palette[2], fontSize: 18),
                      )),
              Text(
                'Chapters Read',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.55), fontSize: 13),
              )
            ],
          ),
          Column(
            children: [
              Consumer(
                  builder: (context, ref, child) => Text(
                        "${mainStats.averageScore.toStringAsFixed(1)}",
                        style: TextStyle(color: palette[2], fontSize: 18),
                      )),
              Text(
                'Mean Score',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.55), fontSize: 13),
              )
            ],
          )
        ],
      ),
    );
  }
}
