import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';

import 'library_reading_screen.dart';

enum ReadingOrderByEnum { alphabetical, lastRead, lastUpdated }

final orderReadingProvider = StateProvider.autoDispose<ReadingOrderByEnum?>(
  (ref) => null,
);
final orderASCReadingProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);

final waitingMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      1, MangaUserStatusEnum.READING);
});

final filteredWaitingMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderReadingProvider);
  var orderASCFilter = ref.watch(orderASCReadingProvider);
  var readingMangas = ref
          .watch(waitingMangasProvider)
          .asData
          ?.value
          .where(
              (element) => element.manga.chaptersCount == element.chaptersRead)
          .toList() ??
      [];

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

/*
final filteredReadingMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderReadingProvider);
  var readingMangas = ref.watch(readingMangasProvider);

  return readingMangas.when(
      data: (data) => data, error: (_, __) => [], loading: () => []);
});


*/
class LibraryWaitingScreen extends ConsumerWidget {
  const LibraryWaitingScreen({super.key});

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
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 300,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Modal BottomSheet'),
                                  ElevatedButton(
                                    child: const Text('Close BottomSheet'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const Text('Show Only with New Chapters'),
                                  const Text('Manga Type'),
                                  const Text('Show Only with New Chapters'),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.filter_alt))),
            Expanded(
                flex: 4,
                child: Center(
                    child: Text(
                        '${ref.watch(filteredWaitingMangasProvider).length.toString()} Mangas'))),
            Expanded(
              child: PopupMenuButton(
                tooltip: 'Order By',
                initialValue: ref.watch(orderReadingProvider),
                onSelected: (selected) {
                  if (ref.read(orderReadingProvider) == selected) {
                    ref.watch(orderASCReadingProvider.notifier).state =
                        !ref.watch(orderASCReadingProvider);
                  } else {
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
              children: ref
                  .watch(filteredWaitingMangasProvider)
                  .map((e) => LibraryReadingMangaTile(e))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
