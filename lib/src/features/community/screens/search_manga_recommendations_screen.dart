import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/community/providers/community.providers.dart';

import '../components/searched_manga_recommendation_card.dart';

class SearchMangaRecommendationsScreen extends StatelessWidget {
  const SearchMangaRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Consumer(
              builder: (context, ref, child) => Text(
                  "Recommendations (${ref.watch(searchRecommendationsControllerProvider.select((value) => value.searchedMangas)).length})")),
        ),
        body: SingleChildScrollView(
            child: Consumer(
          builder: (context, ref, child) => ref
                  .watch(searchRecommendationsControllerProvider)
                  .isLoadingSearchedMangas
              ? Column(
                  children: [LinearProgressIndicator()],
                )
              : GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 9 / 16,
                  padding: EdgeInsets.all(12),
                  children: ref
                      .watch(searchRecommendationsControllerProvider
                          .select((value) => value.searchedMangas))
                      .map((e) => SearchedMangaRecommendationCard(e))
                      .toList(),
                ),
        )));
  }
}
