import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_source.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';

import 'manga_sources_state.dart';

class MangaSourcesController extends StateNotifier<MangaSourcesState> {
  MangaSourcesController(this.ref, this.mangaId)
      : super(MangaSourcesState(
            scrappedList: [], selectedScrapped: [], existingSources: [])) {
    fetchMangaInfo();
    fetchMangaSources();
  }

  Ref ref;
  int mangaId;
  TextEditingController searchController = TextEditingController();

  Future fetchMangaInfo() async {
    state = state.copyWith(isLoadingManga: true);
    var manga = await ref.watch(mangaRepositoryProvider).getMangaById(mangaId);
    state = state.copyWith(isLoadingManga: false, manga: manga);

    searchController.value = TextEditingValue(text: manga.name);
    searchMangaScrappers();
  }

  Future fetchMangaSources() async {
    state = state.copyWith(isLoadingExistingSources: true);
    try {
      var sources =
          await ref.watch(mangaRepositoryProvider).getMangaSourcesById(mangaId);
      state = state.copyWith(
          isLoadingExistingSources: false,
          existingSources: sources.toList(),
          selectedScrapped: sources.toList());
    } catch (ex) {
      state = state.copyWith(isLoadingExistingSources: false);
    }
  }

  Future searchMangaScrappers() async {
    state = state.copyWith(isLoadingNewScrappers: true);
    try {
      var scrappedList = await ref
          .watch(mangaRepositoryProvider)
          .searchMangaSource(searchController.text);
      scrappedList
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      state = state.copyWith(
          isLoadingNewScrappers: false, scrappedList: scrappedList);
    } catch (ex) {
      state = state.copyWith(isLoadingNewScrappers: false);
    }
  }

  Future addMangaSources() async {
    state = state.copyWith(isSaving: true, isLoadingExistingSources: true);
    var existingSources = await ref
        .watch(mangaRepositoryProvider)
        .linkSourcesToManga(mangaId, state.selectedScrapped);
    state = state.copyWith(
        isSaving: false,
        isLoadingExistingSources: false,
        existingSources: existingSources);
  }

  void changeSelectionFromSource(bool selected, MangaSource manga) {
    if (selected) {
      state =
          state.copyWith(selectedScrapped: state.selectedScrapped..add(manga));
    } else {
      state = state.copyWith(
          selectedScrapped: state.selectedScrapped..remove(manga));
    }
  }
}
