import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/search_manga_query.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';

import 'manga_search_state.dart';

final mangaSearchProvider =
    StateNotifierProvider.autoDispose<MangaSearchController, MangaSearchState>(
        (ref) => MangaSearchController(ref));

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
