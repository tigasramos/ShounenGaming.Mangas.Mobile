import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

class RecentMangaCard extends StatelessWidget {
  final MangaInfo manga;
  const RecentMangaCard(this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          top: 15,
          bottom: 5,
          left: 2,
          right: 2,
        ),
        child: InkWell(
          onTap: () {
            navigationKey.currentState?.push(
              MaterialPageRoute(
                  builder: (context) => MangaProfileScreen(manga.id)),
            );
          },
          child: AspectRatio(
            aspectRatio: 9 / 16.5,
            child: Container(
              //width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Badge(
                          badgeContent: Container(
                            child: Center(
                                child: Text(
                              "${manga.averageScore?.toStringAsFixed(1)}",
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            )),
                          ),
                          badgeAnimation: const BadgeAnimation.fade(),
                          position: BadgePosition.topEnd(top: -10),
                          badgeStyle: BadgeStyle(
                              shape: BadgeShape.circle,
                              //borderRadius: BorderRadius.circular(3),
                              padding: const EdgeInsets.all(4),
                              badgeColor: palette[0]),
                          child: MangaImage(manga.imagesUrls[0],
                              isNSFW: manga.isNSFW))),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          manga.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // Icon(
                      //   Icons.star,
                      //   color: Colors.amber,
                      //   size: 10,
                      // ),
                      // SizedBox(
                      //   width: 2,
                      // ),
                      // Text(
                      //   "${manga.averageScore?.toStringAsFixed(1)}",
                      //   style: TextStyle(fontSize: 10),
                      // )
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
          ),
        ));
  }
}
