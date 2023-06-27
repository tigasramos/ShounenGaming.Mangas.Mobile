import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';

final ignoredMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      1, MangaUserStatusEnum.IGNORED);
});

class LibraryIgnoredScreen extends ConsumerWidget {
  const LibraryIgnoredScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(ignoredMangasProvider).when(
          data: (data) => Column(
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
                          onPressed: () {},
                          icon: const Icon(Icons.filter_alt))),
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Text(' Mangas')
                        ],
                      ))),
                  Expanded(
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.sort))) //or Tune
                ]),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 110,
                  crossAxisSpacing: 10,
                  shrinkWrap: true,
                  childAspectRatio: 0.70,
                  mainAxisSpacing: 10,
                  children:
                      data.map((e) => LibraryIgnoredMangaTile(e)).toList(),
                ),
              )
            ],
          ),
          error: (error, stackTrace) => Container(
            child: Text(error.toString()),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class LibraryIgnoredMangaTile extends StatelessWidget {
  final MangaUserData manga;
  const LibraryIgnoredMangaTile(this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Expanded(
              child: CachedNetworkImage(
                  errorWidget: (context, url, error) =>
                      const CircularProgressIndicator(),
                  imageUrl: manga.manga.imagesUrls[0])),
          Text(manga.manga.name)
        ],
      ),
    );
  }
}
