import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/latest_release_manga.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';
import 'package:shounengaming_mangas_mobile/src/others/shared_components/manga_image.dart';

class MangaReleaseCard extends StatelessWidget {
  final LatestReleaseManga mangaRelease;
  const MangaReleaseCard(this.mangaRelease, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) => MangaProfileScreen(mangaRelease.manga.id)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            MangaImage(mangaRelease.manga.imagesUrls[0],
                isNSFW: mangaRelease.manga.isNSFW),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mangaRelease.manga.name,
                    overflow: TextOverflow.ellipsis,
                    //minFontSize: 12,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 15, height: 1.2, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    mangaRelease.manga.tags.join(", "),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(fontSize: 12),
                  ),
                  const Spacer(),
                  ...mangaRelease.releasedChapters.values.take(2).map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 13,
                                width: 18,
                                child: CountryFlag(
                                    country: e.translation ==
                                            TranslationLanguageEnum.PT
                                        ? Country.pt
                                        : Country.gb),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text("#${e.name}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 13)),
                              const Spacer(),
                              Text(
                                  DateFormat("dd MMM yyyy").format(e.createdAt),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
