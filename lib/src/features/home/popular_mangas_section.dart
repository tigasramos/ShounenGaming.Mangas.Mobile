import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

final popularMangasProvider = FutureProvider.autoDispose((ref) async {
  var mangasRepo = ref.watch(mangaRepositoryProvider);
  return await mangasRepo.getPopularMangas();
});

class PopularMangasSection extends ConsumerWidget {
  const PopularMangasSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Popular Mangas',
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
          SizedBox(
              height: 140,
              child: ref.watch(popularMangasProvider).when(
                  data: (data) => ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) =>
                            PopularMangaCard(index + 1, data[index]),
                      ),
                  error: (error, stacktrace) => Container(),
                  loading: () => Container()))
        ],
      ),
    );
  }
}

class PopularMangaCard extends StatelessWidget {
  final int index;
  final MangaInfo manga;
  const PopularMangaCard(this.index, this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(builder: (context) => MangaProfileScreen(manga.id)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 5,
          left: 2,
          right: 2,
        ),
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              Expanded(
                  child: Badge(
                      badgeContent: Text(
                        '#$index',
                        style: const TextStyle(fontSize: 12),
                      ),
                      badgeAnimation: const BadgeAnimation.fade(),
                      position: BadgePosition.topStart(),
                      badgeStyle: BadgeStyle(
                          shape: BadgeShape.circle,
                          padding: const EdgeInsets.all(4),
                          badgeColor: palette[0]),
                      child: MangaImage(manga.imagesUrls[0]))),
              const SizedBox(
                height: 3,
              ),
              SizedBox(
                height: 20,
                child: Text(
                  manga.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
