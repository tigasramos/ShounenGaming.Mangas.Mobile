import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state_provider.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';
import 'package:shounengaming_mangas_mobile/src/others/shared_components/manga_image.dart';

final ignoredMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id, MangaUserStatusEnum.IGNORED);
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
                  crossAxisCount: MediaQuery.of(context).size.width < 550
                      ? 3
                      : MediaQuery.of(context).size.width ~/ 120,
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
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}

class LibraryIgnoredMangaTile extends StatelessWidget {
  final MangaUserData manga;
  const LibraryIgnoredMangaTile(this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) => MangaProfileScreen(manga.manga.id)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: MangaImage(manga.manga.imagesUrls[0],
                    isNSFW: manga.manga.isNSFW)),
            Text(
              manga.manga.name,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
