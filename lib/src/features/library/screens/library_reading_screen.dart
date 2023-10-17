import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import '../providers/library.providers.dart';
import '../providers/library_filters.dart';

class LibraryReadingScreen extends ConsumerWidget {
  const LibraryReadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var prevState = ref.watch(readingViewModeListProvider);
    return Column(
      children: ref.watch(readingMangasProvider).isLoading
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
                          tooltip: 'Grid View',
                          onPressed: () {
                            ref
                                .read(readingViewModeListProvider.notifier)
                                .state = !prevState;
                            ref.read(sharedPreferencesProvider).setBool(
                                localStorageReadingListView, !prevState);

                            // TODO: Modal for Filters
                            // showModalBottomSheet<void>(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return SizedBox(
                            //       height: 300,
                            //       child: Center(
                            //         child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: <Widget>[
                            //             const Text('Modal BottomSheet'),
                            //             ElevatedButton(
                            //               child: const Text('Close BottomSheet'),
                            //               onPressed: () => Navigator.pop(context),
                            //             ),
                            //             const Text('Show Only with New Chapters'),
                            //             const Text('Manga Type'),
                            //             const Text('Show Only with New Chapters'),
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
                          },
                          icon: const Icon(Icons.grid_view))),
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            ref
                                .watch(filteredReadingMangasProvider)
                                .length
                                .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(' Mangas')
                        ],
                      ))),
                  Expanded(
                    child: PopupMenuButton(
                      tooltip: 'Order By',
                      initialValue: ref.watch(orderReadingProvider),
                      onSelected: (selected) {
                        if (ref.read(orderReadingProvider) == selected) {
                          //If selects the same and is Desc, clears order by
                          if (!ref.watch(orderASCReadingProvider)) {
                            ref.watch(orderReadingProvider.notifier).state =
                                null;
                            ref.watch(orderASCReadingProvider.notifier).state =
                                true;
                          }
                          // If select the same and its asc, goes desc
                          else {
                            ref.watch(orderASCReadingProvider.notifier).state =
                                !ref.watch(orderASCReadingProvider);
                          }
                        }
                        // If not the same changes and goes asc
                        else {
                          ref.watch(orderReadingProvider.notifier).state =
                              selected;
                          ref.watch(orderASCReadingProvider.notifier).state =
                              true;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: ReadingOrderByEnum.alphabetical,
                          child: Row(
                            children: [
                              const Text('Alphabetical'),
                              const Spacer(),
                              if (ref.watch(orderReadingProvider) ==
                                  ReadingOrderByEnum.alphabetical)
                                Icon(ref.watch(orderASCReadingProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: ReadingOrderByEnum.lastRead,
                          child: Row(
                            children: [
                              const Text('Last Read'),
                              const Spacer(),
                              if (ref.watch(orderReadingProvider) ==
                                  ReadingOrderByEnum.lastRead)
                                Icon(ref.watch(orderASCReadingProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: ReadingOrderByEnum.lastUpdated,
                          child: Row(
                            children: [
                              const Text('Last Updated'),
                              const Spacer(),
                              if (ref.watch(orderReadingProvider) ==
                                  ReadingOrderByEnum.lastUpdated)
                                Icon(ref.watch(orderASCReadingProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                      ],
                      child: const Icon(Icons.sort),
                    ),
                  ), //or Tune
                ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: prevState
                      ? Column(
                          children: [
                            for (int i = 0;
                                i <
                                    ref
                                        .watch(filteredReadingMangasProvider)
                                        .length;
                                i++)
                              LibraryReadingMangaTile(
                                  i, filteredReadingMangasProvider)
                          ],
                        )
                      : GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount:
                              MediaQuery.of(context).size.width < 550
                                  ? 3
                                  : MediaQuery.of(context).size.width ~/ 120,
                          shrinkWrap: true,
                          childAspectRatio: 0.70,
                          children: ref
                              .watch(filteredReadingMangasProvider)
                              .map((e) => LibraryReadingMangaCard(e))
                              .toList(),
                        ),
                ),
              ),
            ],
    );
  }
}

class LibraryReadingMangaTile extends ConsumerWidget {
  final int index;
  final AutoDisposeProvider<List<MangaUserData>> provider;
  const LibraryReadingMangaTile(this.index, this.provider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mangaUserData = ref.watch(provider)[index];
    return InkWell(
      onTap: () async {
        await navigationKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) => MangaProfileScreen(mangaUserData.manga.id)),
        );
        ref.invalidate(readingMangasProvider);
        ref.invalidate(onHoldMangasProvider);
        ref.invalidate(waitingMangasProvider);
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
            MangaImage(mangaUserData.manga.imagesUrls[0],
                isNSFW: mangaUserData.manga.isNSFW),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          mangaUserData.manga.name,
                          minFontSize: 14,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              height: 1.2),
                        ),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      if (mangaUserData.rating != null)
                        RatingBar.builder(
                          initialRating: mangaUserData.rating!,
                          minRating: 0,
                          itemSize: 12,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                    ],
                  ),
                  Text(
                    '${mangaUserData.manga.type.name}, ${mangaUserData.manga.startedAt?.year ?? "?"} - ${mangaUserData.manga.finishedAt?.year ?? "Releasing"}',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        '${mangaUserData.filteredReadChapters} / ${mangaUserData.filteredTotalChapters}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      minHeight: 9,
                      color: palette[1],
                      value: mangaUserData.filteredTotalChapters == 0
                          ? 0
                          : mangaUserData.filteredReadChapters /
                              mangaUserData.filteredTotalChapters,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        'Last Chapter: ',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 9, color: Colors.white70),
                      ),
                      Text(
                        mangaUserData.manga.lastChapterDate != null
                            ? DateFormat("dd MMM yyyy")
                                .format(mangaUserData.manga.lastChapterDate!)
                            : "Not Found",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 11,
                                ),
                      ),
                    ],
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

class LibraryReadingMangaCard extends StatelessWidget {
  final MangaUserData userData;
  const LibraryReadingMangaCard(this.userData, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) => MangaProfileScreen(userData.manga.id)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: Badge(
                    badgeContent: Text(
                      (userData.filteredTotalChapters -
                              userData.filteredReadChapters)
                          .toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    badgeAnimation: const BadgeAnimation.fade(),
                    badgeStyle: BadgeStyle(
                        badgeColor: palette[0],
                        borderRadius: BorderRadius.circular(10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 6),
                        shape: BadgeShape.square),
                    child: MangaImage(userData.manga.imagesUrls[0],
                        isNSFW: userData.manga.isNSFW))),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 35,
              child: AutoSizeText(
                userData.manga.name,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
