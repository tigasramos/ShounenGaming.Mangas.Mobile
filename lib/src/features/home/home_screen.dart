import 'package:flutter/material.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/featured_mangas_section.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/latest_releases_section.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/popular_mangas_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 00, vertical: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeaturedMangasSection(),
            PopularMangasSection(),
            LatestReleasesSection()
          ],
        ),
      ),
    );
  }
}
