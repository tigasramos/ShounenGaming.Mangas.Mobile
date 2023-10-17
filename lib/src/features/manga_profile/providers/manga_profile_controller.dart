import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state.providers.dart';

import 'manga_profile_state.dart';

class MangaProfileController extends StateNotifier<MangaProfileState> {
  MangaProfileController(this.ref, this.mangaId) : super(MangaProfileState()) {
    state = state.copyWith(
        selectedLanguage:
            ref.watch(appStateProvider).userConfigs?.translationLanguage);
    fetchMangaInfo();
    fetchMangaUserData();
  }

  Ref ref;
  int mangaId;

  void calculateNextChapter() {
    if (state.manga == null) return;

    if (state.manga!.chapters.isEmpty) {
      state = state.copyWith(nextChapterId: -1);
      return;
    }

    // First Time Reading
    if (state.userData == null) {
      state = state.copyWith(
          nextChapterId:
              state.manga!.chapters[state.manga!.chapters.length - 1].id);
      return;
    }

    // Calculate
    var chaptersNotRead = state.manga!.chapters
        .where((chapter) => chapter.translations.any(
            (translation) => translation.language == state.selectedLanguage))
        .toList()
      ..removeWhere(
          (chapter) => state.userData!.chaptersRead.contains(chapter.id));

    state = state.copyWith(
        nextChapterId: chaptersNotRead.isEmpty
            ? -1
            : state.listInverted
                ? chaptersNotRead.first.id
                : chaptersNotRead.last.id);
  }

  Future fetchMangaInfo() async {
    state = state.copyWith(isLoadingManga: true);
    var manga = await ref.watch(mangaRepositoryProvider).getMangaById(mangaId);
    state = state.copyWith(isLoadingManga: false, manga: manga);

    if (!manga.chapters.any((c) =>
        c.translations.any((t) => t.language == TranslationLanguageEnum.PT))) {
      state = state.copyWith(selectedLanguage: TranslationLanguageEnum.EN);
    }
    calculateNextChapter();
  }

  Future fetchMangaUserData() async {
    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .getDataByMangaByUser(
            mangaId, ref.watch(appStateProvider).loggedUser!.id);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
    calculateNextChapter();
  }

  Future changeMangaUserStatus(MangaUserStatusEnum? newStatus) async {
    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .updateMangaStatusByUser(mangaId, newStatus);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future changeMangaUserRating(double rating) async {
    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .updateMangaRatingByUser(mangaId, rating == 0 ? null : rating);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  void changeSelectedLanguage(TranslationLanguageEnum language) async {
    state = state.copyWith(selectedLanguage: language);
    calculateNextChapter();
  }

  void revertChaptersList() {
    var stateManga = state.manga;
    stateManga?.chapters = stateManga.chapters.reversed.toList();
    state =
        state.copyWith(manga: stateManga, listInverted: !state.listInverted);
  }

  Future readChapter(int chapterId) async {
    if (state.manga == null ||
        (state.userData != null &&
            state.userData!.chaptersRead.contains(chapterId))) return;

    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .markChaptersRead([chapterId]);

    state = state.copyWith(isLoadingUserData: false, userData: userData);
    calculateNextChapter();
  }

  Future readUntilChapter(int chapterId) async {
    if (state.manga == null) return;
    state = state.copyWith(isLoadingUserData: true);

    var userData = state.userData;
    var reversedList = state.manga!.chapters.toList().reversed;

    var chaptersIds = <int>[];
    for (var chapter in reversedList) {
      if (userData == null || !userData.chaptersRead.contains(chapter.id)) {
        chaptersIds.add(chapter.id);
      }
      if (chapterId == chapter.id) {
        break;
      }
    }
    userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .markChaptersRead(chaptersIds);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
    calculateNextChapter();
  }

  Future unreadChapter(int chapterId) async {
    if (state.manga == null ||
        (state.userData != null &&
            !state.userData!.chaptersRead.contains(chapterId))) return;

    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .unmarkChaptersRead([chapterId]);

    state = state.copyWith(isLoadingUserData: false, userData: userData);
    calculateNextChapter();
  }

  Future unreadUntilChapter(int chapterId) async {
    if (state.manga == null || state.userData == null) return;
    state = state.copyWith(isLoadingUserData: true);
    var userData = state.userData;

    var chaptersIds = <int>[];
    for (var chapter in state.manga!.chapters) {
      if (userData != null && userData.chaptersRead.contains(chapter.id)) {
        chaptersIds.add(chapter.id);
      }
      if (chapterId == chapter.id) {
        break;
      }
    }

    userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .unmarkChaptersRead(chaptersIds);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
    calculateNextChapter();
  }

  Future fetchNewChapters() async {
    var repo = ref.watch(mangaRepositoryProvider);
    await repo.fetchChaptersForManga(mangaId);
  }
}
