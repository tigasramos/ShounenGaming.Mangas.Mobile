import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

class HomeMangaCard extends StatelessWidget {
  final MangaInfo manga;
  final String? badgeLabel;
  const HomeMangaCard(this.manga, {super.key, this.badgeLabel});

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
                  child: badgeLabel != null
                      ? Badge(
                          badgeContent: Container(
                            width: 22,
                            child: Center(
                              child: Text(
                                badgeLabel!,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          badgeAnimation: const BadgeAnimation.fade(),
                          position: BadgePosition.topStart(top: -10),
                          badgeStyle: BadgeStyle(
                              shape: BadgeShape.circle,
                              padding: const EdgeInsets.all(4),
                              badgeColor: palette[0]),
                          child: MangaImage(manga.imagesUrls[0],
                              isNSFW: manga.isNSFW))
                      : MangaImage(manga.imagesUrls[0], isNSFW: manga.isNSFW)),
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
