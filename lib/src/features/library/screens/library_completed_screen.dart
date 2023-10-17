import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shounengaming_mangas_mobile/src/features/library/providers/library_filters.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';

import '../providers/library.providers.dart';

class LibraryCompletedScreen extends ConsumerWidget {
  const LibraryCompletedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: ref.watch(completedMangasProvider).isLoading
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
                              '${ref.watch(filteredCompletedMangasProvider).length} Mangas'))),
                  Expanded(
                    child: PopupMenuButton(
                      tooltip: 'Order By',
                      initialValue: ref.watch(orderCompletedProvider),
                      onSelected: (selected) {
                        if (ref.read(orderCompletedProvider) == selected) {
                          //If selects the same and is Desc, clears order by
                          if (!ref.watch(orderASCCompletedProvider)) {
                            ref.watch(orderCompletedProvider.notifier).state =
                                null;
                            ref
                                .watch(orderASCCompletedProvider.notifier)
                                .state = true;
                          }
                          // If select the same and its asc, goes desc
                          else {
                            ref
                                .watch(orderASCCompletedProvider.notifier)
                                .state = !ref.watch(orderASCCompletedProvider);
                          }
                        }
                        // If not the same changes and goes asc
                        else {
                          ref.watch(orderCompletedProvider.notifier).state =
                              selected;
                          ref.watch(orderASCCompletedProvider.notifier).state =
                              true;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: CompletedOrderByEnum.alphabetical,
                          child: Row(
                            children: [
                              const Text('Alphabetical'),
                              const Spacer(),
                              if (ref.watch(orderCompletedProvider) ==
                                  CompletedOrderByEnum.alphabetical)
                                Icon(ref.watch(orderASCCompletedProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: CompletedOrderByEnum.completedDate,
                          child: Row(
                            children: [
                              const Text('Completed At'),
                              const Spacer(),
                              if (ref.watch(orderCompletedProvider) ==
                                  CompletedOrderByEnum.completedDate)
                                Icon(ref.watch(orderASCCompletedProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: CompletedOrderByEnum.rating,
                          child: Row(
                            children: [
                              const Text('Rating'),
                              const Spacer(),
                              if (ref.watch(orderCompletedProvider) ==
                                  CompletedOrderByEnum.rating)
                                Icon(ref.watch(orderASCCompletedProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                      ],
                      child: const Icon(Icons.sort),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < ref.watch(filteredCompletedMangasProvider).length;
                          i++)
                        LibraryCompletedMangaTile(i)
                    ],
                  ),
                ),
              ),
            ],
    );
  }
}

class LibraryCompletedMangaTile extends ConsumerWidget {
  final int index;
  const LibraryCompletedMangaTile(this.index, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mangaUserData = ref.watch(filteredCompletedMangasProvider)[index];
    return InkWell(
      onTap: () async {
        await navigationKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) => MangaProfileScreen(mangaUserData.manga.id)),
        );
        ref.invalidate(completedMangasProvider);
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
                  AutoSizeText(
                    mangaUserData.manga.name,
                    minFontSize: 14,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  Text(
                    '${mangaUserData.manga.type.name}, ${mangaUserData.manga.startedAt?.year ?? "?"} - ${mangaUserData.manga.finishedAt?.year ?? "Releasing"}',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const Spacer(),
                  if (mangaUserData.rating != null)
                    Row(
                      children: [
                        const Spacer(),
                        RatingBar.builder(
                          initialRating: mangaUserData.rating!,
                          minRating: 0,
                          itemSize: 18,
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
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (mangaUserData.manga.myAnimeListId != null) ...[
                        GestureDetector(
                          onTap: () async {
                            try {
                              await launch(
                                'https://myanimelist.net/manga/${mangaUserData.manga.myAnimeListId}',
                                customTabsOption: CustomTabsOption(
                                  toolbarColor: Theme.of(context).primaryColor,
                                  enableDefaultShare: true,
                                  enableUrlBarHiding: true,
                                  showPageTitle: true,
                                ),
                                safariVCOption: SafariViewControllerOption(
                                  preferredBarTintColor:
                                      Theme.of(context).primaryColor,
                                  preferredControlTintColor: Colors.white,
                                  barCollapsingEnabled: true,
                                  entersReaderIfAvailable: false,
                                  dismissButtonStyle:
                                      SafariViewControllerDismissButtonStyle
                                          .close,
                                ),
                              );
                            } catch (e, stackTrace) {
                              await Sentry.captureException(e,
                                  stackTrace: stackTrace);
                              debugPrint(e.toString());
                            }
                          },
                          child: Image.asset(
                            "assets/images/sources/mal_icon.png",
                            height: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      if (mangaUserData.manga.anilistId != null)
                        GestureDetector(
                          onTap: () async {
                            try {
                              await launch(
                                'https://anilist.co/manga/${mangaUserData.manga.anilistId}',
                                customTabsOption: CustomTabsOption(
                                  toolbarColor: Theme.of(context).primaryColor,
                                  enableDefaultShare: true,
                                  enableUrlBarHiding: true,
                                  showPageTitle: true,
                                ),
                                safariVCOption: SafariViewControllerOption(
                                  preferredBarTintColor:
                                      Theme.of(context).primaryColor,
                                  preferredControlTintColor: Colors.white,
                                  barCollapsingEnabled: true,
                                  entersReaderIfAvailable: false,
                                  dismissButtonStyle:
                                      SafariViewControllerDismissButtonStyle
                                          .close,
                                ),
                              );
                            } catch (e, stackTrace) {
                              await Sentry.captureException(e,
                                  stackTrace: stackTrace);
                              debugPrint(e.toString());
                            }
                          },
                          child: Image.asset(
                            "assets/images/sources/al_icon.png",
                            height: 25,
                          ),
                        ),
                      const Spacer(),
                      Text(
                        'Completed At: ',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 9, color: Colors.white70),
                      ),
                      Text(
                        mangaUserData.addedToStatusDate != null
                            ? DateFormat("dd MMM yyyy")
                                .format(mangaUserData.addedToStatusDate!)
                            : "Not Found",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 11,
                                ),
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
