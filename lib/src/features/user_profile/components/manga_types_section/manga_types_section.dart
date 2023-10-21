import 'package:flutter/material.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_type_enum.dart';

import 'manga_types_pie_chart.dart';

class MangaTypesSection extends StatelessWidget {
  final Map<MangaTypeEnum, int> mangaTypesStats;
  const MangaTypesSection(this.mangaTypesStats, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Types',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          MangaTypesPieChart(mangaTypesStats),
        ],
      ),
    );
  }
}
