import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

final mangasFromTagProvider =
    FutureProvider.family.autoDispose((ref, String tag) async {
  var mangasRepo = ref.watch(mangaRepositoryProvider);

  var mangas = await mangasRepo.getMangasFromTag(tag);
  mangas.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return mangas;
});

class TagScreen extends ConsumerWidget {
  final String tag;
  const TagScreen(this.tag, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '$tag Mangas (${ref.watch(mangasFromTagProvider(tag)).asData?.value.length ?? "0"})'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: ref.watch(mangasFromTagProvider(tag)).when(
                data: (data) => [
                  const SizedBox(
                    height: 4,
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.of(context).size.width < 550
                        ? 3
                        : MediaQuery.of(context).size.width ~/ 120,
                    shrinkWrap: true,
                    childAspectRatio: 0.70,
                    children: data.map((e) => TagMangaCard(e)).toList(),
                  ),
                ],
                error: (error, stackTrace) => [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(error.toString())
                ],
                loading: () => [const LinearProgressIndicator()],
              ),
        ),
      ),
    );
  }
}

class TagMangaCard extends ConsumerWidget {
  final MangaInfo manga;
  const TagMangaCard(this.manga, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(builder: (context) => MangaProfileScreen(manga.id)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: Badge(
                    badgeContent: Text(
                      manga.chaptersCount.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    badgeAnimation: const BadgeAnimation.fade(),
                    badgeStyle: BadgeStyle(
                        badgeColor: palette[0],
                        borderRadius: BorderRadius.circular(10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 6),
                        shape: BadgeShape.square),
                    child:
                        MangaImage(manga.imagesUrls[0], isNSFW: manga.isNSFW))),
            const SizedBox(
              height: 4,
            ),
            SizedBox(
              height: 35,
              child: AutoSizeText(
                manga.name,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
