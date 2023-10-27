import 'package:shounengaming_mangas_mobile/src/data/models/manga_translation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';

enum ReadingDirectionEnum { VERTICAL, VERTICAL_PAGED, HORIZONTAL_PAGED }

class ChapterProfileState {
  MangaTranslation? translation;
  MangaUserData? userData;

  ReadingDirectionEnum readingMode;
  int currentPage;
  double currentPagePercentage;
  bool showingAppBar;

  bool isLoadingUserData;
  bool isLoadingTranslation;

  ChapterProfileState({
    this.translation,
    this.userData,
    this.currentPage = 1,
    this.readingMode = ReadingDirectionEnum.VERTICAL,
    this.showingAppBar = true,
    this.currentPagePercentage = 100,
    this.isLoadingTranslation = true,
    this.isLoadingUserData = true,
  });
  @override
  String toString() {
    return '($isLoadingTranslation, $readingMode, $currentPage, $currentPagePercentage, $isLoadingUserData, $translation, $userData)';
  }

  ChapterProfileState copyWith({
    MangaTranslation? translation,
    MangaUserData? userData,
    int? currentPage,
    double? currentPagePercentage,
    bool? showingAppBar,
    ReadingDirectionEnum? readingMode,
    bool? isLoadingTranslation,
    bool? isLoadingUserData,
  }) {
    return ChapterProfileState(
      translation: translation ?? this.translation,
      userData: userData ?? this.userData,
      currentPage: currentPage ?? this.currentPage,
      currentPagePercentage:
          currentPagePercentage ?? this.currentPagePercentage,
      readingMode: readingMode ?? this.readingMode,
      showingAppBar: showingAppBar ?? this.showingAppBar,
      isLoadingTranslation: isLoadingTranslation ?? this.isLoadingTranslation,
      isLoadingUserData: isLoadingUserData ?? this.isLoadingUserData,
    );
  }
}
