import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/community/providers/community.providers.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import 'manga_recommendation_card.dart';

class MangasRecommendationsSection extends StatelessWidget {
  const MangasRecommendationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  'Recommendations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    //TODO: Refresh
                  },
                  child: Text(
                    'Refresh',
                    style: TextStyle(color: palette[3], fontSize: 12),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: Consumer(
            builder: (context, ref, child) =>
                ref.watch(mangaRecommendationsProvider).when(
                      data: (data) => ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 15,
                                ),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) => Container(
                                child: MangaRecommendationCard(data[index]))),
                      ),
                      error: (error, stackTrace) => Container(),
                      loading: () => Container(),
                    ),
          ))
        ],
      ),
    );
  }
}
