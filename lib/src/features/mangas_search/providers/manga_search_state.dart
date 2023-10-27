import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';

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
