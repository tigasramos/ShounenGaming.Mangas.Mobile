import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';

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
              height: 135,
              child: ref.watch(popularMangasProvider).when(
                  data: (data) => ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) => PopularMangaCard(
                            data[index].id,
                            data[index].name,
                            data[index].imagesUrls[0]),
                      ),
                  error: (error, stacktrace) => Container(),
                  loading: () => const CircularProgressIndicator()))
        ],
      ),
    );
  }
}

class PopularMangaCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String name;
  const PopularMangaCard(this.id, this.name, this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(builder: (context) => MangaProfileScreen(id)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 5,
        ),
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                    aspectRatio: 0.66,
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) =>
                          const CircularProgressIndicator(),
                      fit: BoxFit.fitWidth,
                      filterQuality: FilterQuality.high,
                      imageUrl: imageUrl,
                    )),
              ),
              SizedBox(
                height: 16,
                child: AutoSizeText(
                  name,
                  maxLines: 1,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
