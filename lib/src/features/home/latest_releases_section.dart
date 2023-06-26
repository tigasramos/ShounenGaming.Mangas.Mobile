import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/chapter_release.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';

final newChaptersProvider = FutureProvider.autoDispose((ref) async {
  var mangasRepo = ref.watch(mangaRepositoryProvider);
  return await mangasRepo.getRecentlyReleasedChapters();
});

class LatestReleasesSection extends ConsumerWidget {
  const LatestReleasesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Latest Releases',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: 1,
                  minHeight: 1,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: ref.watch(newChaptersProvider).when(
                data: (data) => data.map((e) => ChapterReleaseCard(e)).toList(),
                error: (error, stacktrace) => [Container()],
                loading: () => [const CircularProgressIndicator()]),
          )
        ]));
  }
}

class ChapterReleaseCard extends StatelessWidget {
  final ChapterRelease chapterRelease;
  const ChapterReleaseCard(this.chapterRelease, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) =>
                  MangaProfileScreen(chapterRelease.manga.id)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        height: 100,
        child: Row(
          children: [
            AspectRatio(
                aspectRatio: 0.66,
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) =>
                      const CircularProgressIndicator(),
                  fit: BoxFit.fitHeight,
                  filterQuality: FilterQuality.high,
                  imageUrl: chapterRelease.manga.imagesUrls[0],
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    chapterRelease.manga.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    chapterRelease.manga.tags.join(", "),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        height: 13,
                        width: 18,
                        child: CountryFlag(country: Country.pt),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "#${chapterRelease.name}",
                      ),
                      const Spacer(),
                      Text(
                        DateFormat("dd MMM yyyy")
                            .format(chapterRelease.createdAt),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
