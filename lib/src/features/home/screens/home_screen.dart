import 'package:flutter/material.dart';

import '../components/popular_mangas_section.dart';
import '../components/latest_releases_section.dart';
import '../components/recent_mangas_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopularMangasSection(),
            RecentMangasSection(),
            LatestReleasesSection()
          ],
        ),
      ),
    );
  }
}
