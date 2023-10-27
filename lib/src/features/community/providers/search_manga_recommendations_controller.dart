// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_metadata_source_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_metadata.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';

class SearchMangaRecommendationsController
    extends StateNotifier<SearchMangaRecommendationsState> {
  SearchMangaRecommendationsController(this.ref)
      : super(SearchMangaRecommendationsState(
            addedMangas: [], searchedMangas: [])) {
    _initialLoad();
  }
  Ref ref;

  Future _initialLoad() async {
    try {
      var mangaRepo = ref.watch(mangaRepositoryProvider);
      state = state.copyWith(isLoadingSearchedMangas: true);
      var mangas = await mangaRepo.searchMangaRecommendations();
      state = state.copyWith(searchedMangas: mangas);
    } catch (e, stackTrace) {
      print(e);
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
    state = state.copyWith(isLoadingSearchedMangas: false);
  }

  Future addManga(int id, MangaMetadataSourceEnum source) async {
    try {
      var mangaRepo = ref.watch(mangaRepositoryProvider);
      state = state.copyWith(isLoadingAddManga: true);
      var manga = await mangaRepo.addManga(id, source);
      state = state.copyWith(addedMangas: [...state.addedMangas, manga]);
    } catch (e, stackTrace) {
      print(e);
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
    state = state.copyWith(isLoadingAddManga: false);
  }
}

class SearchMangaRecommendationsState {
  final List<Manga> addedMangas;
  final List<MangaMetadata> searchedMangas;
  final bool isLoadingSearchedMangas;
  final bool isLoadingAddManga;

  SearchMangaRecommendationsState({
    required this.addedMangas,
    required this.searchedMangas,
    this.isLoadingSearchedMangas = false,
    this.isLoadingAddManga = false,
  });

  SearchMangaRecommendationsState copyWith({
    List<Manga>? addedMangas,
    List<MangaMetadata>? searchedMangas,
    bool? isLoadingSearchedMangas,
    bool? isLoadingAddManga,
  }) {
    return SearchMangaRecommendationsState(
      addedMangas: addedMangas ?? this.addedMangas,
      searchedMangas: searchedMangas ?? this.searchedMangas,
      isLoadingSearchedMangas:
          isLoadingSearchedMangas ?? this.isLoadingSearchedMangas,
      isLoadingAddManga: isLoadingAddManga ?? this.isLoadingAddManga,
    );
  }
}
