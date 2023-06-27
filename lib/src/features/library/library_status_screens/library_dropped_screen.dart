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

enum DroppedOrderByEnum { alphabetical, droppedDate }

final orderDroppedProvider = StateProvider.autoDispose<DroppedOrderByEnum?>(
  (ref) => null,
);
final orderASCDroppedProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);

final droppedMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      1, MangaUserStatusEnum.DROPPED);
});

final filteredDroppedMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderDroppedProvider);
  var orderASCFilter = ref.watch(orderASCDroppedProvider);
  var droppedMangas = ref.watch(droppedMangasProvider).asData?.value ?? [];

  switch (orderFilter) {
    case DroppedOrderByEnum.alphabetical:
      return droppedMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case DroppedOrderByEnum.droppedDate:
      return droppedMangas
        ..sort((a, b) =>
            (a.addedToStatusDate == null
                ? 0
                : b.addedToStatusDate == null
                    ? 1
                    : a.addedToStatusDate!.compareTo(b.addedToStatusDate!)) *
            (orderASCFilter ? 1 : -1));

    default:
      return droppedMangas;
  }
});

class LibraryDroppedScreen extends ConsumerWidget {
  const LibraryDroppedScreen({super.key});

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
                        '${ref.watch(filteredDroppedMangasProvider).length.toString()} Mangas'))),
            Expanded(
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.sort))) //or Tune
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: ref
                  .watch(filteredDroppedMangasProvider)
                  .map((e) => LibraryDroppedMangaTile(e))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class LibraryDroppedMangaTile extends StatelessWidget {
  final MangaUserData mangaUserData;
  const LibraryDroppedMangaTile(this.mangaUserData, {super.key});

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
            MangaImage(mangaUserData.manga.imagesUrls[0]),
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
                    style: TextStyle(shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(1, 2),
                        blurRadius: 4.0,
                        color: Theme.of(context).primaryColor,
                      ),
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
                        '${mangaUserData.chaptersRead.length} / ${mangaUserData.manga.chaptersCount}',
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
                      value: mangaUserData.manga.chaptersCount == 0
                          ? 0
                          : mangaUserData.chaptersRead.length /
                              mangaUserData.manga.chaptersCount,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        'Dropped at: ${mangaUserData.addedToStatusDate != null ? DateFormat("dd MMM yyyy").format(mangaUserData.addedToStatusDate!) : "Not Found"}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 11),
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
