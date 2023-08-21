import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/reading_mode_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state_provider.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';

import 'chapter_reading_progress.dart';
import 'chapter_state.dart';

final chapterProfileProvider = StateNotifierProvider.autoDispose.family<
        ChapterProfileController, ChapterProfileState, ChapterScreenParameters>(
    (ref, args) => ChapterProfileController(ref, args));

class ChapterScreenParameters {
  int mangaId;
  int chapterId;
  TranslationLanguageEnum language;
  ChapterScreenParameters(
      {required this.mangaId, required this.chapterId, required this.language});
  @override
  bool operator ==(covariant ChapterScreenParameters other) {
    if (identical(this, other)) return true;

    return other.mangaId == mangaId &&
        other.chapterId == chapterId &&
        other.language == language;
  }

  @override
  int get hashCode {
    return mangaId.hashCode ^ chapterId.hashCode ^ language.hashCode;
  }
}

class ChapterProfileController extends StateNotifier<ChapterProfileState> {
  ChapterProfileController(this.ref, ChapterScreenParameters args)
      : super(ChapterProfileState()) {
    fetchMangaUserData(args.mangaId);
    fetchMangaTranslation(args.mangaId, args.chapterId, args.language);
  }

  final Ref ref;
  PageController scrollController = PageController();
  ItemScrollController scrollVerticalController = ItemScrollController();
  ScrollOffsetListener scrollVerticalListener = ScrollOffsetListener.create();
  ItemPositionsListener scrollVerticalItemsListener =
      ItemPositionsListener.create();

  void resetVerticalScrolls() {
    if (state.readingMode != ReadingDirectionEnum.VERTICAL) return;

    scrollVerticalController = ItemScrollController();
    scrollVerticalItemsListener = ItemPositionsListener.create();
    scrollVerticalListener = ScrollOffsetListener.create();
    scrollVerticalListener.changes.listen((event) {
      if (!mounted) return;

      if (scrollVerticalItemsListener.itemPositions.value.first.index == 0 &&
          event > 0) return;
      if (state.showingAppBar && event > 0) {
        state = state.copyWith(showingAppBar: false);
      } else if (!state.showingAppBar && event < -0.5) {
        state = state.copyWith(showingAppBar: true);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void calculateReadingDirection() {
    var readingMode = ReadingDirectionEnum.VERTICAL;
    switch (ref.watch(appStateProvider).userConfigs?.readingMode) {
      case ReadingModeTypeEnum.ALWAYS_HORIZONTAL:
        readingMode = ReadingDirectionEnum.HORIZONTAL_PAGED;
        break;
      case ReadingModeTypeEnum.ALWAYS_VERTICAL:
        readingMode = ReadingDirectionEnum.VERTICAL;
        break;
      case ReadingModeTypeEnum.ALWAYS_VERTICAL_PAGED:
        readingMode = ReadingDirectionEnum.VERTICAL_PAGED;
      case ReadingModeTypeEnum.HORIZONTAL_MANGAS_OTHERS_VERTICAL:
        if (state.translation?.mangaType == MangaTypeEnum.MANGA) {
          readingMode = ReadingDirectionEnum.HORIZONTAL_PAGED;
        } else {
          readingMode = ReadingDirectionEnum.VERTICAL;
        }
        break;
      default:
        break;
    }
    state = state.copyWith(readingMode: readingMode);

    resetVerticalScrolls();
  }

  Future fetchMangaTranslation(
      int mangaId, int chapterId, TranslationLanguageEnum language) async {
    state = state.copyWith(isLoadingTranslation: true);
    var mangaTranslation = await ref
        .watch(mangaRepositoryProvider)
        .getMangaTranslation(mangaId, chapterId, language);
    state = state.copyWith(
        isLoadingTranslation: false, translation: mangaTranslation);

    calculateReadingDirection();

    // Scroll to Last Page
    String? lastPagesProgressString = ref
        .watch(sharedPreferencesProvider)
        .getString(
            "$localStorageChapterProgress${state.translation!.chapterId}");
    if (lastPagesProgressString == null) return;

    ChapterReadingProgress lastPagesProgress =
        ChapterReadingProgress.fromJson(lastPagesProgressString);

    if (lastPagesProgress.language != mangaTranslation.language) {
      return;
    }

    await animateToPage(lastPagesProgress.page);
  }

  Future animateToPage(int page, {int milliseconds = 500}) async {
    await Future.delayed(Duration(milliseconds: milliseconds), () async {
      if (state.readingMode == ReadingDirectionEnum.VERTICAL) {
        if (scrollVerticalController.isAttached) {
          await scrollVerticalController.scrollTo(
              index: page - 1, duration: const Duration(milliseconds: 500));
        }
      } else {
        if (scrollController.hasClients) {
          await scrollController.animateToPage(page - 1,
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 500));
        }
      }
    });
  }

  Future fetchMangaUserData(int mangaId) async {
    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .getDataByMangaByUser(
            mangaId, ref.watch(appStateProvider).loggedUser!.id);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future<ReadingDirectionEnum> rotateReading() async {
    var readingMode = ReadingDirectionEnum.values[
        (state.readingMode.index + 1) % ReadingDirectionEnum.values.length];
    state = state.copyWith(currentPagePercentage: 0, readingMode: readingMode);

    resetVerticalScrolls();

    await animateToPage(state.currentPage, milliseconds: 500);

    return readingMode;
  }

  void changeAppBarVisibility() {
    if (state.readingMode == ReadingDirectionEnum.VERTICAL) {
      state = state.copyWith(showingAppBar: !state.showingAppBar);
    }
  }

  Future<bool> readChapter() async {
    if (state.translation == null) return false;
    try {
      state = state.copyWith(isLoadingUserData: true);
      var userData = await ref
          .watch(mangaUsersRepositoryProvider)
          .markChaptersRead([state.translation!.chapterId]);
      state = state.copyWith(isLoadingUserData: false, userData: userData);
      return true;
    } on Exception catch (e, stackTrace) {
      await Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<bool> unreadChapter() async {
    if (state.translation == null) return false;

    try {
      state = state.copyWith(isLoadingUserData: true);
      var userData = await ref
          .watch(mangaUsersRepositoryProvider)
          .unmarkChaptersRead([state.translation!.chapterId]);
      state = state.copyWith(isLoadingUserData: false, userData: userData);
      return true;
    } on Exception catch (e, stackTrace) {
      await Sentry.captureException(e, stackTrace: stackTrace);
      return false;
    }
  }

  Future automaticReadChapter(
      String key, double percentage, bool paginatedList) async {
    if (state.translation == null || state.isLoadingUserData) return;

    var currentPage =
        state.translation!.pages.indexWhere((element) => element == key) + 1;
    // Same Page (Update Percentage)
    if (currentPage == state.currentPage) {
      state = state.copyWith(currentPagePercentage: percentage);
    }
    // Higher Percentage (Update Page)
    else if (percentage > state.currentPagePercentage) {
      state = state.copyWith(
          currentPage: currentPage, currentPagePercentage: percentage);
    }
    // Same Percentage (Biggest Page)
    else if (percentage == state.currentPagePercentage) {
      if (paginatedList || state.currentPage < currentPage) {
        state = state.copyWith(
            currentPage: currentPage, currentPagePercentage: percentage);
      }
    } else {
      return;
    }

    final sharedPrefs = ref.watch(sharedPreferencesProvider);
    String? lastPagesProgressString = sharedPrefs.getString(
        "$localStorageChapterProgress${state.translation!.chapterId}");

    ChapterReadingProgress? lastPagesProgress = lastPagesProgressString == null
        ? null
        : ChapterReadingProgress.fromJson(lastPagesProgressString);

    var isLastPage = state.currentPage == state.translation!.pages.length;
    if (isLastPage) {
      // Show Bar
      state = state.copyWith(showingAppBar: true);

      // Delete from Local Storage
      await sharedPrefs.remove(
          "$localStorageChapterProgress${state.translation!.chapterId}");
    } else {
      //Save in SharedPreferences
      lastPagesProgress = ChapterReadingProgress(
          chapterId: state.translation!.chapterId,
          language: state.translation!.language,
          page: currentPage);
      await sharedPrefs.setString(
          "$localStorageChapterProgress${state.translation!.chapterId}",
          lastPagesProgress.toJson());
    }

    if (state.translation!.pages.indexWhere((element) => element == key) <
        state.translation!.pages.length - 2) return;

    if (state.userData != null &&
        state.userData!.chaptersRead.contains(state.translation!.chapterId)) {
      return;
    }

    await readChapter();
  }

  bool shouldShowButtons() {
    bool isFirstPage = state.currentPage == 1 ||
        (scrollVerticalItemsListener.itemPositions.value.isNotEmpty &&
            scrollVerticalItemsListener.itemPositions.value.first.index == 0 &&
            scrollVerticalItemsListener
                    .itemPositions.value.first.itemLeadingEdge <
                0.5);
    bool isLastPage =
        state.currentPage == (state.translation?.pages.length ?? 0) - 1 ||
            (scrollVerticalItemsListener.itemPositions.value.isNotEmpty &&
                scrollVerticalItemsListener.itemPositions.value.last.index ==
                    (state.translation?.pages.length ?? 0) - 1 &&
                scrollVerticalItemsListener
                        .itemPositions.value.last.itemTrailingEdge <
                    1.25);

    return isFirstPage || isLastPage;
  }
}
