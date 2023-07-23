import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

/*
Each Filter and Sort is a StateProvider
the list is a Provider from those StateProviders + FutureProvider
*/

enum ReadingOrderByEnum { alphabetical, lastRead, lastUpdated }

final orderReadingProvider = StateProvider.autoDispose<ReadingOrderByEnum?>(
  (ref) => null,
);
final orderASCReadingProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);

final readingMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id, MangaUserStatusEnum.READING);
});

final filteredReadingMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderReadingProvider);
  var orderASCFilter = ref.watch(orderASCReadingProvider);
  var readingMangas = ref.watch(readingMangasProvider).asData?.value;
  readingMangas = readingMangas
          ?.where((element) =>
              element.filteredReadChapters < element.filteredTotalChapters)
          .toList() ??
      [];

  // Default Order be Last Updated Desc
  if (orderFilter == null) {
    orderFilter = ReadingOrderByEnum.lastRead;
    orderASCFilter = false;
  }

  switch (orderFilter) {
    case ReadingOrderByEnum.alphabetical:
      return readingMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case ReadingOrderByEnum.lastRead:
      return readingMangas
        ..sort((a, b) =>
            (a.finishedReadingDate == null
                ? 0
                : b.finishedReadingDate == null
                    ? 1
                    : a.finishedReadingDate!
                        .compareTo(b.finishedReadingDate!)) *
            (orderASCFilter ? 1 : -1));
    case ReadingOrderByEnum.lastUpdated:
      return readingMangas
        ..sort((a, b) =>
            (a.manga.lastChapterDate == null
                ? 0
                : b.manga.lastChapterDate == null
                    ? 1
                    : a.manga.lastChapterDate!
                        .compareTo(b.manga.lastChapterDate!)) *
            (orderASCFilter ? 1 : -1));
    default:
      return readingMangas;
  }
});

class LibraryReadingScreen extends ConsumerWidget {
  const LibraryReadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
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
                    tooltip: 'Filters',
                    onPressed: () {
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
                    icon: const Icon(Icons.filter_alt))),
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
                      ref.watch(orderReadingProvider.notifier).state = null;
                      ref.watch(orderASCReadingProvider.notifier).state = true;
                    }
                    // If select the same and its asc, goes desc
                    else {
                      ref.watch(orderASCReadingProvider.notifier).state =
                          !ref.watch(orderASCReadingProvider);
                    }
                  }
                  // If not the same changes and goes asc
                  else {
                    ref.watch(orderReadingProvider.notifier).state = selected;
                    ref.watch(orderASCReadingProvider.notifier).state = true;
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
            child: Column(
              children: [
                for (int i = 0;
                    i < ref.watch(filteredReadingMangasProvider).length;
                    i++)
                  LibraryReadingMangaTile(i, filteredReadingMangasProvider)
              ],
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
                    minFontSize: 16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(shadows: <Shadow>[
                      // Shadow(
                      //   offset: const Offset(1, 2),
                      //   blurRadius: 4.0,
                      //   color: Theme.of(context).primaryColor,
                      // ),
                    ], fontSize: 21, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  Text(
                    '${mangaUserData.manga.type.name}, ${mangaUserData.manga.startedAt?.year ?? "?"}-${mangaUserData.manga.finishedAt?.year ?? "?"}',
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
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
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}
