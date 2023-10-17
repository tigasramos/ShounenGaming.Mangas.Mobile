import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_metadata_source_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';

import 'manga_add_state.dart';

class MangaAddController extends StateNotifier<MangaAddState> {
  MangaAddController(this.ref)
      : super(MangaAddState(
          searchedMangas: [],
          isLoadingMangas: false,
          isAddingMangas: false,
          selectedMangas: [],
          selectedSource: MangaMetadataSourceEnum.MYANIMELIST,
        ));

  Ref ref;
  TextEditingController searchController = TextEditingController();

  Future search() async {
    if (searchController.text.length < 3) return;

    try {
      state = state.copyWith(
          isLoadingMangas: true, searchedMangas: [], selectedMangas: []);
      var mangas = await ref
          .watch(mangaRepositoryProvider)
          .searchMangaMetadata(searchController.text, state.selectedSource);
      state = state.copyWith(searchedMangas: mangas);
    } catch (e) {
      print(e);
    }

    state = state.copyWith(isLoadingMangas: false);
  }

  Future addMangas() async {
    try {
      state = state.copyWith(isAddingMangas: true);
      for (var mangaId in state.selectedMangas) {
        await ref
            .watch(mangaRepositoryProvider)
            .addManga(mangaId, state.selectedSource);
      }
      await search();
    } catch (e) {
      print(e);
    }

    state = state.copyWith(isAddingMangas: false);
  }

  void changeSelectedSource(MangaMetadataSourceEnum selectedSource) {
    state = state.copyWith(
        selectedSource: selectedSource, selectedMangas: [], searchedMangas: []);
  }

  void changeMangaSelection(int mangaId) {
    if (state.selectedMangas.contains(mangaId)) {
      state = state.copyWith(
          selectedMangas: state.selectedMangas
            ..removeWhere((element) => element == mangaId));
    } else {
      state =
          state.copyWith(selectedMangas: state.selectedMangas..add(mangaId));
    }
  }
}
