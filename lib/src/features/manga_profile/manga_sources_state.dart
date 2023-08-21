import 'package:shounengaming_mangas_mobile/src/data/models/manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_source.dart';

class MangaSourcesState {
  Manga? manga;
  List<MangaSource> scrappedList;
  List<MangaSource> existingSources;
  List<MangaSource> selectedScrapped;

  bool isLoadingManga;
  bool isLoadingExistingSources;
  bool isLoadingNewScrappers;
  bool isSaving;

  MangaSourcesState(
      {this.manga,
      required this.scrappedList,
      required this.selectedScrapped,
      required this.existingSources,
      this.isLoadingManga = true,
      this.isLoadingExistingSources = true,
      this.isLoadingNewScrappers = false,
      this.isSaving = false});

  MangaSourcesState copyWith({
    Manga? manga,
    List<MangaSource>? existingSources,
    List<MangaSource>? scrappedList,
    List<MangaSource>? selectedScrapped,
    bool? isLoadingManga,
    bool? isLoadingExistingSources,
    bool? isLoadingNewScrappers,
    bool? isSaving,
  }) {
    return MangaSourcesState(
      manga: manga ?? this.manga,
      scrappedList: scrappedList ?? this.scrappedList,
      selectedScrapped: selectedScrapped ?? this.selectedScrapped,
      existingSources: existingSources ?? this.existingSources,
      isLoadingManga: isLoadingManga ?? this.isLoadingManga,
      isLoadingExistingSources:
          isLoadingExistingSources ?? this.isLoadingExistingSources,
      isLoadingNewScrappers:
          isLoadingNewScrappers ?? this.isLoadingNewScrappers,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
