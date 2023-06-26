// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/search_manga_query.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/manga_image.dart';

//TODO: Search from synopsys aswell, not only name

final mangaSearchProvider =
    StateNotifierProvider.autoDispose<MangaSearchController, MangaSearchState>(
        (ref) => MangaSearchController(ref));

class MangaSearchState {
  List<MangaInfo> searchedMangas;
  int totalCount;

  int currentPage;

  bool isLoadingMangas;

  MangaSearchState({
    required this.searchedMangas,
    required this.totalCount,
    required this.currentPage,
    required this.isLoadingMangas,
  });

  MangaSearchState copyWith({
    List<MangaInfo>? searchedMangas,
    int? totalCount,
    int? currentPage,
    bool? isLoadingMangas,
  }) {
    return MangaSearchState(
      searchedMangas: searchedMangas ?? this.searchedMangas,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMangas: isLoadingMangas ?? this.isLoadingMangas,
    );
  }
}

class MangaSearchController extends StateNotifier<MangaSearchState> {
  MangaSearchController(this.ref)
      : super(MangaSearchState(
            isLoadingMangas: false,
            searchedMangas: [],
            totalCount: 0,
            currentPage: 1)) {
    search();
  }

  Ref ref;
  TextEditingController searchController = TextEditingController();

  Future loadNextPage() async {
    state = state.copyWith(
        isLoadingMangas: true, currentPage: state.currentPage + 1);
    var mangas = await ref.watch(mangaRepositoryProvider).searchMangas(
        SearchMangaQuery(name: searchController.text), state.currentPage);
    state = state.copyWith(
      isLoadingMangas: false,
      searchedMangas: state.searchedMangas..addAll(mangas.data),
    );
  }

  Future search() async {
    state = state.copyWith(
        isLoadingMangas: true, searchedMangas: [], currentPage: 1);
    var mangas = await ref.watch(mangaRepositoryProvider).searchMangas(
        SearchMangaQuery(name: searchController.text), state.currentPage);
    state = state.copyWith(
        isLoadingMangas: false,
        searchedMangas: mangas.data,
        totalCount: mangas.maxCount);
  }
}

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchState = ref.watch(mangaSearchProvider);
    var functions = ref.read(mangaSearchProvider.notifier);

    return NotificationListener<ScrollEndNotification>(
      onNotification: (scrollEnd) {
        final metrics = scrollEnd.metrics;
        if (metrics.atEdge) {
          bool isTop = metrics.pixels == 0;
          if (!isTop) {
            functions.loadNextPage();
          }
        }
        return true;
      },
      child: SingleChildScrollView(
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
                    controller: functions.searchController,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: const EdgeInsets.all(8),
                        isDense: true,
                        suffixIcon: IconButton(
                          onPressed: functions.searchController.clear,
                          icon: const Icon(Icons.clear),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                  ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  onPressed: () async {
                    await functions.search();
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
                    TextSpan(
                        text: searchState.totalCount.toString(),
                        style: const TextStyle(color: Colors.white)),
                    const TextSpan(text: ' Results')
                  ])),
              const SizedBox(
                height: 5,
              ),
              // ...ref.watch(searchMangaProvider).when(
              //     data: (data) =>
              //         data.data.map((e) => MangaSearchedTile(e)).toList(),
              //     error: (error, stacktrace) => [Container()],
              //     loading: () => [const CircularProgressIndicator()])
              ListView.builder(
                itemBuilder: (context, index) =>
                    MangaSearchedTile(searchState.searchedMangas[index]),
                itemCount: searchState.searchedMangas.length,
                shrinkWrap: true,
              ),
            ],
          ),
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
                child: MangaImage(manga.imagesUrls[0])),
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
                    overflow: TextOverflow.ellipsis,
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
