import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_translation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:visibility_detector/visibility_detector.dart';

final chapterProfileProvider = StateNotifierProvider.family<
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

class ChapterProfileState {
  MangaTranslation? translation;
  MangaUserData? userData;

  int currentPage;
  double currentPagePercentage;

  bool isLoadingUserData;
  bool isLoadingTranslation;

  ChapterProfileState({
    this.translation,
    this.userData,
    this.currentPage = 1,
    this.currentPagePercentage = 100,
    this.isLoadingTranslation = true,
    this.isLoadingUserData = true,
  });
  @override
  String toString() {
    return '($isLoadingTranslation, $currentPage, $currentPagePercentage, $isLoadingUserData, $translation, $userData)';
  }

  ChapterProfileState copyWith({
    MangaTranslation? translation,
    MangaUserData? userData,
    int? currentPage,
    double? currentPagePercentage,
    bool? isLoadingTranslation,
    bool? isLoadingUserData,
  }) {
    return ChapterProfileState(
      translation: translation ?? this.translation,
      userData: userData ?? this.userData,
      currentPage: currentPage ?? this.currentPage,
      currentPagePercentage:
          currentPagePercentage ?? this.currentPagePercentage,
      isLoadingTranslation: isLoadingTranslation ?? this.isLoadingTranslation,
      isLoadingUserData: isLoadingUserData ?? this.isLoadingUserData,
    );
  }
}

class ChapterProfileController extends StateNotifier<ChapterProfileState> {
  ChapterProfileController(this.ref, ChapterScreenParameters args)
      : super(ChapterProfileState()) {
    fetchMangaTranslation(args.mangaId, args.chapterId, args.language);
    fetchMangaUserData(args.mangaId);
  }

  final Ref ref;

  Future fetchMangaTranslation(
      int mangaId, int chapterId, TranslationLanguageEnum language) async {
    state = state.copyWith(isLoadingTranslation: true);
    var mangaTranslation = await ref
        .watch(mangaRepositoryProvider)
        .getMangaTranslation(mangaId, chapterId, language);
    state = state.copyWith(
        isLoadingTranslation: false, translation: mangaTranslation);
  }

  Future fetchMangaUserData(int mangaId) async {
    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .getDataByMangaByUser(mangaId, 1);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future readChapter() async {
    if (state.translation == null) return;

    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .markChapterRead(state.translation!.chapterId);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future unreadChapter() async {
    if (state.translation == null) return;

    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .unmarkChapterRead(state.translation!.chapterId);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future automaticReadChapter(String key, double percentage) async {
    if (state.translation == null) return;

    var currentPage =
        state.translation!.pages.indexWhere((element) => element == key) + 1;
    if (currentPage == state.currentPage) {
      state = state.copyWith(currentPagePercentage: percentage);
    } else if (percentage > state.currentPagePercentage) {
      state = state.copyWith(
          currentPage: currentPage, currentPagePercentage: percentage);
    }

    if (state.translation!.pages.indexWhere((element) => element == key) <
        state.translation!.pages.length - 2) return;

    if (state.userData == null) return;
    if (state.userData!.chaptersRead.contains(state.translation!.chapterId)) {
      return;
    }

    await readChapter();
  }
}

class ChapterScreen extends ConsumerWidget {
  final int mangaId;
  final int chapterId;
  final TranslationLanguageEnum language;
  const ChapterScreen(this.mangaId, this.chapterId, this.language, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var chapterState = ref.watch(chapterProfileProvider(ChapterScreenParameters(
        mangaId: mangaId, chapterId: chapterId, language: language)));
    var functions = ref.read(chapterProfileProvider(ChapterScreenParameters(
            mangaId: mangaId, chapterId: chapterId, language: language))
        .notifier);

    if (chapterState.isLoadingTranslation) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        //TODO: Change to Sliver
        title: Text('Chapter #${chapterState.translation!.chapterNumber}'),
        actions: [
          SizedBox(
            width: 22,
            height: 16,
            child: CountryFlag(
              country: chapterState.translation!.language ==
                      TranslationLanguageEnum.PT
                  ? Country.pt
                  : Country.gb,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          chapterState.userData == null ||
                  !chapterState.userData!.chaptersRead.contains(chapterId)
              ? const Tooltip(
                  message: 'Not Watched', child: Icon(Icons.visibility))
              : const Tooltip(message: 'Already Seen', child: Icon(Icons.done)),
          // PopupMenuButton(
          //   itemBuilder: (context) {
          //     return [
          //       const PopupMenuItem(child: Text('Mark Chapter')),
          //       const PopupMenuItem(child: Text('Unmark Chapter')),
          //     ];
          //   },
          // ),
          //IconButton(onPressed: (){}, icon: icon)

          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                    children: chapterState.translation!.pages
                        .map((e) => InteractiveViewer(
                              child: VisibilityDetector(
                                key: Key(e),
                                onVisibilityChanged: (info) {
                                  functions.automaticReadChapter(
                                      e, info.visibleFraction);
                                },
                                child: CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                        const CircularProgressIndicator(),
                                    imageUrl: e,
                                    httpHeaders:
                                        chapterState.translation!.pageHeaders,
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fitWidth,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator()),
                              ),
                            ))
                        .toList()),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: const BoxDecoration(color: Colors.black45),
                    child: Text(
                        "${chapterState.currentPage}/${chapterState.translation!.pages.length}"),
                  )),
              if (chapterState.currentPage == 1 ||
                  (chapterState.translation == null &&
                      chapterState.translation!.pages.length ==
                          chapterState.currentPage)) ...[
                if (chapterState.translation!.previousChapterTranslationId !=
                    null)
                  Positioned(
                    left: 20,
                    bottom: 25,
                    child: FloatingActionButton(
                        heroTag: "back",
                        onPressed: () {},
                        child: const Icon(Icons.arrow_back)),
                  ),
                if (chapterState.translation!.nextChapterTranslationId != null)
                  Positioned(
                    right: 20,
                    bottom: 25,
                    child: FloatingActionButton(
                        heroTag: "next",
                        onPressed: () {},
                        child: const Icon(Icons.arrow_forward)),
                  )
              ]
            ],
          )),
    );
  }
}
