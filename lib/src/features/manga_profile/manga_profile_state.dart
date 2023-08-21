import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';

class MangaProfileState {
  Manga? manga;
  MangaUserData? userData;

  TranslationLanguageEnum selectedLanguage;

  int nextChapterId;
  bool listInverted;

  bool isLoadingManga;
  bool isLoadingUserData;
  bool isLoading() => isLoadingManga || isLoadingUserData;
  MangaProfileState({
    this.manga,
    this.userData,
    this.listInverted = false,
    this.nextChapterId = -1,
    this.selectedLanguage = TranslationLanguageEnum.PT,
    this.isLoadingManga = true,
    this.isLoadingUserData = true,
  });

  MangaProfileState copyWith({
    Manga? manga,
    MangaUserData? userData,
    TranslationLanguageEnum? selectedLanguage,
    int? nextChapterId,
    bool? listInverted,
    bool? isLoadingManga,
    bool? isLoadingUserData,
  }) {
    return MangaProfileState(
      manga: manga ?? this.manga,
      userData: isLoadingUserData != null && !isLoadingUserData
          ? userData
          : (userData ?? this.userData),
      nextChapterId: nextChapterId ?? this.nextChapterId,
      listInverted: listInverted ?? this.listInverted,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isLoadingManga: isLoadingManga ?? this.isLoadingManga,
      isLoadingUserData: isLoadingUserData ?? this.isLoadingUserData,
    );
  }
}
