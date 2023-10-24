import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';

class MangaRecommendationCard extends StatelessWidget {
  final MangaInfo manga;
  const MangaRecommendationCard(this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(builder: (context) => MangaProfileScreen(manga.id)),
        );
      },
      child: Container(
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: MangaImage(manga.imagesUrls[0])),
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    manga.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    minFontSize: 10,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 10,
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "${manga.averageScore?.toStringAsFixed(1)}",
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
            Text(
              manga.tags.join(", "),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 9, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
