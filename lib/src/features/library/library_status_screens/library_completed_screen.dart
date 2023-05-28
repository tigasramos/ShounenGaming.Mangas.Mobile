import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';

enum CompletedOrderByEnum { alphabetical, completedDate }

final orderReadingProvider = StateProvider.autoDispose<CompletedOrderByEnum?>(
  (ref) => null,
);
final orderASCReadingProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);

final completedMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      1, MangaUserStatusEnum.COMPLETED);
});

final filteredCompletedMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderReadingProvider);
  var orderASCFilter = ref.watch(orderASCReadingProvider);
  var completedMangas = ref.watch(completedMangasProvider).asData?.value ?? [];

  switch (orderFilter) {
    case CompletedOrderByEnum.alphabetical:
      return completedMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case CompletedOrderByEnum.completedDate:
      return completedMangas
        ..sort((a, b) =>
            (a.finishedReadingDate == null
                ? 0
                : b.finishedReadingDate == null
                    ? 1
                    : a.finishedReadingDate!
                        .compareTo(b.finishedReadingDate!)) *
            (orderASCFilter ? 1 : -1));

    default:
      return completedMangas;
  }
});

class LibraryCompletedScreen extends ConsumerWidget {
  const LibraryCompletedScreen({super.key});

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
                    onPressed: () {}, icon: const Icon(Icons.filter_alt))),
            Expanded(
                flex: 4,
                child: Center(
                    child: Text(
                        '${ref.watch(filteredCompletedMangasProvider).length} Mangas'))),
            Expanded(
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.sort))) //or Tune
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: ref
                  .watch(filteredCompletedMangasProvider)
                  .map((e) => LibraryCompletedMangaTile(e))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class LibraryCompletedMangaTile extends StatelessWidget {
  final MangaUserData mangaUserData;
  const LibraryCompletedMangaTile(this.mangaUserData, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            CachedNetworkImage(
              imageUrl: mangaUserData.manga.imageUrl,
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitHeight,
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
                    minFontSize: 16,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  Text(
                    '${mangaUserData.manga.type.name}, ${mangaUserData.manga.startedAt?.year ?? "?"}-${mangaUserData.manga.finishedAt?.year ?? "?"}',
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        color: Colors.blue,
                        child: const Text(
                          'MyAnimeList',
                          style: TextStyle(fontSize: 9),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Completed at: ${mangaUserData.finishedReadingDate != null ? DateFormat("dd MMM yyyy").format(mangaUserData.finishedReadingDate!) : "Not Found"}',
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
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}
