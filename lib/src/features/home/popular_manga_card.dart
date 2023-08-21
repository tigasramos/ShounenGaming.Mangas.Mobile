import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';
import 'package:shounengaming_mangas_mobile/src/others/shared_components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

class PopularMangaCard extends StatelessWidget {
  final int index;
  final MangaInfo manga;
  const PopularMangaCard(this.index, this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(builder: (context) => MangaProfileScreen(manga.id)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 5,
          left: 2,
          right: 2,
        ),
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              Expanded(
                  child: Badge(
                      badgeContent: Text(
                        '#$index',
                        style: const TextStyle(fontSize: 12),
                      ),
                      badgeAnimation: const BadgeAnimation.fade(),
                      position: BadgePosition.topStart(),
                      badgeStyle: BadgeStyle(
                          shape: BadgeShape.circle,
                          padding: const EdgeInsets.all(4),
                          badgeColor: palette[0]),
                      child: MangaImage(manga.imagesUrls[0],
                          isNSFW: manga.isNSFW))),
              const SizedBox(
                height: 3,
              ),
              SizedBox(
                height: 20,
                child: Text(
                  manga.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
