import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';

import 'library_reading_screen.dart';

enum OnHoldOrderByEnum { alphabetical, lastRead, lastUpdated }

final orderOnHoldProvider = StateProvider.autoDispose<OnHoldOrderByEnum?>(
  (ref) => null,
);
final orderASCOnHoldProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);
final onHoldMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id, MangaUserStatusEnum.ON_HOLD);
});

final filteredOnHoldMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderOnHoldProvider);
  var orderASCFilter = ref.watch(orderASCOnHoldProvider);
  var readingMangas = ref
          .watch(onHoldMangasProvider)
          .asData
          ?.value
          .where((element) =>
              element.chaptersRead.length < element.manga.chaptersCount)
          .toList() ??
      [];

  // Default Order be Last Updated Desc
  if (orderFilter == null) {
    orderFilter = OnHoldOrderByEnum.alphabetical;
    orderASCFilter = false;
  }

  switch (orderFilter) {
    case OnHoldOrderByEnum.alphabetical:
      return readingMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case OnHoldOrderByEnum.lastRead:
      return readingMangas
        ..sort((a, b) =>
            (a.finishedReadingDate == null
                ? 0
                : b.finishedReadingDate == null
                    ? 1
                    : a.finishedReadingDate!
                        .compareTo(b.finishedReadingDate!)) *
            (orderASCFilter ? 1 : -1));
    case OnHoldOrderByEnum.lastUpdated:
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

class LibraryOnHoldScreen extends ConsumerWidget {
  const LibraryOnHoldScreen({super.key});

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
                    tooltip: 'Grid View',
                    onPressed: () {},
                    icon: const Icon(Icons.grid_view))),
            Expanded(
                flex: 4,
                child: Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ref.watch(filteredOnHoldMangasProvider).length.toString(),
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
                initialValue: ref.watch(orderOnHoldProvider),
                onSelected: (selected) {
                  if (ref.read(orderOnHoldProvider) == selected) {
                    //If selects the same and is Desc, clears order by
                    if (!ref.watch(orderASCOnHoldProvider)) {
                      ref.watch(orderOnHoldProvider.notifier).state = null;
                      ref.watch(orderASCOnHoldProvider.notifier).state = true;
                    }
                    // If select the same and its asc, goes desc
                    else {
                      ref.watch(orderASCOnHoldProvider.notifier).state =
                          !ref.watch(orderASCOnHoldProvider);
                    }
                  }
                  // If not the same changes and goes asc
                  else {
                    ref.watch(orderOnHoldProvider.notifier).state = selected;
                    ref.watch(orderASCOnHoldProvider.notifier).state = true;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: OnHoldOrderByEnum.alphabetical,
                    child: Row(
                      children: [
                        const Text('Alphabetical'),
                        const Spacer(),
                        if (ref.watch(orderOnHoldProvider) ==
                            OnHoldOrderByEnum.alphabetical)
                          Icon(ref.watch(orderASCOnHoldProvider)
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: OnHoldOrderByEnum.lastRead,
                    child: Row(
                      children: [
                        const Text('Last Read'),
                        const Spacer(),
                        if (ref.watch(orderOnHoldProvider) ==
                            OnHoldOrderByEnum.lastRead)
                          Icon(ref.watch(orderASCOnHoldProvider)
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: OnHoldOrderByEnum.lastUpdated,
                    child: Row(
                      children: [
                        const Text('Last Updated'),
                        const Spacer(),
                        if (ref.watch(orderOnHoldProvider) ==
                            OnHoldOrderByEnum.lastUpdated)
                          Icon(ref.watch(orderASCOnHoldProvider)
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
                    i < ref.watch(filteredOnHoldMangasProvider).length;
                    i++)
                  LibraryReadingMangaTile(i, filteredOnHoldMangasProvider)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
