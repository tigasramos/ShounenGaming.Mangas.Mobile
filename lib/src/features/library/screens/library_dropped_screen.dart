import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import '../providers/library.providers.dart';

class LibraryDroppedScreen extends ConsumerWidget {
  const LibraryDroppedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: ref.watch(droppedMangasProvider).isLoading
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
                              '${ref.watch(filteredDroppedMangasProvider).length.toString()} Mangas'))),
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

class LibraryDroppedMangaTile extends ConsumerWidget {
  final MangaUserData mangaUserData;
  const LibraryDroppedMangaTile(this.mangaUserData, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await navigationKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) => MangaProfileScreen(mangaUserData.manga.id)),
        );
        ref.invalidate(droppedMangasProvider);
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
                        '${mangaUserData.chaptersRead.length} / ${mangaUserData.manga.chaptersCount}',
                        style: const TextStyle(fontSize: 10),
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
                      color: palette[1],
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
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
