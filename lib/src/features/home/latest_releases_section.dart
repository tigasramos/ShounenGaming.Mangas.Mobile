import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/chapter_release.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          AspectRatio(
              aspectRatio: 0.66,
              child: CachedNetworkImage(
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.high,
                imageUrl: chapterRelease.manga.imageUrl,
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
                InkWell(
                  onTap: () {},
                  child: Text(
                    '#${chapterRelease.name}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Text(
                    '#1059',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
