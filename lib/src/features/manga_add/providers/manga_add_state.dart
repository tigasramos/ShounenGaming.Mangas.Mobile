import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_metadata_source_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_metadata.dart';

class MangaAddState {
  MangaMetadataSourceEnum selectedSource;
  List<int> selectedMangas;

  List<MangaMetadata> searchedMangas;

  bool isLoadingMangas;
  bool isAddingMangas;

  MangaAddState({
    required this.selectedSource,
    required this.selectedMangas,
    required this.searchedMangas,
    required this.isLoadingMangas,
    required this.isAddingMangas,
  });

  MangaAddState copyWith({
    MangaMetadataSourceEnum? selectedSource,
    List<int>? selectedMangas,
    List<MangaMetadata>? searchedMangas,
    bool? isLoadingMangas,
    bool? isAddingMangas,
  }) {
    return MangaAddState(
      selectedSource: selectedSource ?? this.selectedSource,
      selectedMangas: selectedMangas ?? this.selectedMangas,
      searchedMangas: searchedMangas ?? this.searchedMangas,
      isLoadingMangas: isLoadingMangas ?? this.isLoadingMangas,
      isAddingMangas: isAddingMangas ?? this.isAddingMangas,
    );
  }
}
