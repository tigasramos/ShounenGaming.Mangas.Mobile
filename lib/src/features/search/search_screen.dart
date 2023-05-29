import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/manga_image.dart';

//TODO: Search from synopsys aswell, not only name
final searchMangaNameProvider = StateProvider.autoDispose<String>(
  (ref) => "",
);

final searchMangaTagsProvider = StateProvider.autoDispose<List<String>>(
  (ref) => [],
);

final searchMangaProvider = FutureProvider.autoDispose((ref) async {
  var name = ref.read(searchMangaNameProvider);
  var tags = ref.read(searchMangaTagsProvider);

  var mangaRepo = ref.read(mangaRepositoryProvider);

  return await mangaRepo.searchMangas(name: name, tags: tags);
});

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextFormField(
                  initialValue: ref.watch(searchMangaNameProvider),
                  onChanged: (value) =>
                      ref.watch(searchMangaNameProvider.notifier).state = value,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero))),
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
                onPressed: () {
                  ref.invalidate(searchMangaProvider);
                },
                minWidth: double.infinity,
                color: Theme.of(context).primaryColor,
                child: const Text('Search')),
            const SizedBox(
              height: 10,
            ),
            RichText(
                text: TextSpan(
                    text: 'Found ',
                    style: const TextStyle(color: Colors.grey),
                    children: [
                  ref.watch(searchMangaProvider).when(
                        data: (data) => TextSpan(
                            text: data.maxCount.toString(),
                            style: const TextStyle(color: Colors.white)),
                        error: (error, stackTrace) =>
                            const TextSpan(text: 'Error'),
                        loading: () => const TextSpan(text: 'Loading'),
                      ),
                  const TextSpan(text: ' Results')
                ])),
            const SizedBox(
              height: 5,
            ),
            ...ref.watch(searchMangaProvider).when(
                data: (data) =>
                    data.data.map((e) => MangaSearchedTile(e)).toList(),
                error: (error, stacktrace) => [Container()],
                loading: () => [const CircularProgressIndicator()])
          ],
        ),
      ),
    );
  }
}

class MangaSearchedTile extends StatelessWidget {
  final MangaInfo manga;
  const MangaSearchedTile(this.manga, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationKey.currentState?.push(
          MaterialPageRoute(builder: (context) => MangaProfileScreen(manga.id)),
        );
      },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Badge(
                badgeContent: Text(
                  manga.chaptersCount.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
                badgeStyle: BadgeStyle(
                    badgeColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    shape: BadgeShape.square),
                child: MangaImage(manga.imageUrl)),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(manga.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              offset: const Offset(1, 2),
                              blurRadius: 4.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          height: 1.2)),
                  Text(
                    manga.tags.join(", "),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Status: ',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                          children: [
                        TextSpan(
                            text: manga.isReleasing ? 'Releasing' : 'Finished',
                            style: const TextStyle(color: Colors.white)),
                      ])),
                  RichText(
                      text: TextSpan(
                          text: 'Type: ',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                          children: [
                        TextSpan(
                            text: manga.type.name,
                            style: const TextStyle(color: Colors.white)),
                      ])),
                  RichText(
                      text: TextSpan(
                          text: 'Last Update: ',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                          children: [
                        TextSpan(
                            text:
                                ' ${manga.lastChapterDate != null ? DateFormat("dd MMM yyyy").format(manga.lastChapterDate!) : "Not Found"}',
                            style: const TextStyle(color: Colors.white)),
                      ])),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
