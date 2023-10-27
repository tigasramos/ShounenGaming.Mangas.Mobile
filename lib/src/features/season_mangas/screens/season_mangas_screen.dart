import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import '../providers/season_mangas.providers.dart';

class SeasonMangasScreen extends ConsumerWidget {
  const SeasonMangasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Season Mangas (${ref.watch(seasonMangasProvider).value?.length ?? 0})'),
        ),
        body: ref.watch(seasonMangasProvider).when(
              data: (data) => GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width < 550
                    ? 3
                    : MediaQuery.of(context).size.width ~/ 120,
                shrinkWrap: true,
                childAspectRatio: 0.70,
                children: data
                    .map((manga) => InkWell(
                          onTap: () {
                            navigationKey.currentState?.push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MangaProfileScreen(manga.id)),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Badge(
                                  position: BadgePosition.topStart(
                                      start: -6, top: -4),
                                  badgeContent: const SizedBox(
                                    height: 7,
                                    width: 7,
                                  ),
                                  badgeAnimation: const BadgeAnimation.fade(),
                                  badgeStyle: BadgeStyle(
                                      badgeColor: manga.isReleasing
                                          ? Colors.green
                                          : Colors.redAccent,
                                      borderRadius: BorderRadius.circular(10),
                                      borderGradient:
                                          const BadgeGradient.linear(colors: [
                                        Colors.black,
                                        Colors.black
                                      ]),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 2),
                                      shape: BadgeShape.square),
                                  child: Badge(
                                      badgeContent: Text(
                                        manga.chaptersCount.toString(),
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      badgeAnimation:
                                          const BadgeAnimation.fade(),
                                      badgeStyle: BadgeStyle(
                                          badgeColor: palette[0],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 6),
                                          shape: BadgeShape.square),
                                      child: MangaImage(manga.imagesUrls[0],
                                          isNSFW: manga.isNSFW)),
                                )),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: 35,
                                  child: AutoSizeText(
                                    manga.name,
                                    minFontSize: 10,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const LinearProgressIndicator(),
            ));
  }
}
