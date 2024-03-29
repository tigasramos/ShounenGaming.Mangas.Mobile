import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';

import '../providers/library.providers.dart';

class LibraryPlanningScreen extends ConsumerWidget {
  const LibraryPlanningScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: ref.watch(planningMangasProvider).isLoading
          ? [
              const LinearProgressIndicator(
                minHeight: 2,
              )
            ]
          : [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                height: 50,
                color: Theme.of(context)
                    .scaffoldBackgroundColor
                    .withBlue(35)
                    .withRed(30),
                child: Row(children: [
                  Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.filter_alt))),
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: Text(
                              '${ref.watch(filteredPlanningMangasProvider).length.toString()} Mangas'))),
                  Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.sort))) //or Tune
                ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: ref
                        .watch(filteredPlanningMangasProvider)
                        .map((e) => LibraryPlanningMangTile(e))
                        .toList(),
                  ),
                ),
              ),
            ],
    );
  }
}

class LibraryPlanningMangTile extends StatelessWidget {
  final MangaUserData mangaUserData;
  const LibraryPlanningMangTile(this.mangaUserData, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) => MangaProfileScreen(mangaUserData.manga.id)),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Badge(
              badgeContent: Text(
                mangaUserData.manga.chaptersCount.toString(),
                style: const TextStyle(fontSize: 9),
              ),
              badgeAnimation: const BadgeAnimation.fade(),
              badgeStyle: BadgeStyle(
                  shape: BadgeShape.square,
                  badgeColor: Theme.of(context).primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  borderRadius: BorderRadius.circular(2)),
              child: MangaImage(mangaUserData.manga.imagesUrls[0],
                  isNSFW: mangaUserData.manga.isNSFW),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    mangaUserData.manga.name,
                    minFontSize: 14,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  Text(
                    '${mangaUserData.manga.type.name}, ${mangaUserData.manga.startedAt?.year ?? "?"} - ${mangaUserData.manga.finishedAt?.year ?? "Releasing"}',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Text(
                    mangaUserData.manga.tags.join(', '),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        'Added at: ${mangaUserData.addedToStatusDate != null ? DateFormat("dd MMM yyyy").format(mangaUserData.addedToStatusDate!) : "Not Found"}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
