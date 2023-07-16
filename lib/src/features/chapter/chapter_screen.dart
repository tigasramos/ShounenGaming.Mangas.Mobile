import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_translation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:visibility_detector/visibility_detector.dart';

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

class ChapterProfileState {
  MangaTranslation? translation;
  MangaUserData? userData;

  bool verticalReading;
  int currentPage;
  double currentPagePercentage;

  bool isLoadingUserData;
  bool isLoadingTranslation;

  ChapterProfileState({
    this.translation,
    this.userData,
    this.currentPage = 1,
    this.verticalReading = true,
    this.currentPagePercentage = 100,
    this.isLoadingTranslation = true,
    this.isLoadingUserData = true,
  });
  @override
  String toString() {
    return '($isLoadingTranslation, $verticalReading, $currentPage, $currentPagePercentage, $isLoadingUserData, $translation, $userData)';
  }

  ChapterProfileState copyWith({
    MangaTranslation? translation,
    MangaUserData? userData,
    int? currentPage,
    double? currentPagePercentage,
    bool? verticalReading,
    bool? isLoadingTranslation,
    bool? isLoadingUserData,
  }) {
    return ChapterProfileState(
      translation: translation ?? this.translation,
      userData: userData ?? this.userData,
      currentPage: currentPage ?? this.currentPage,
      currentPagePercentage:
          currentPagePercentage ?? this.currentPagePercentage,
      verticalReading: verticalReading ?? this.verticalReading,
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
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
        .getDataByMangaByUser(
            mangaId, ref.watch(appStateProvider).loggedUser!.id);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  void rotateReading() {
    state = state.copyWith(verticalReading: !state.verticalReading);
  }

  Future readChapter() async {
    if (state.translation == null) return;

    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .markChaptersRead([state.translation!.chapterId]);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future unreadChapter() async {
    if (state.translation == null) return;

    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .unmarkChaptersRead([state.translation!.chapterId]);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future automaticReadChapter(String key, double percentage) async {
    if (state.translation == null || state.isLoadingUserData) return;

    var currentPage =
        state.translation!.pages.indexWhere((element) => element == key) + 1;
    if (currentPage == state.currentPage) {
      state = state.copyWith(currentPagePercentage: percentage);
    } else if (percentage >= state.currentPagePercentage) {
      state = state.copyWith(
          currentPage: currentPage, currentPagePercentage: percentage);
    }

    if (state.translation!.pages.indexWhere((element) => element == key) <
        state.translation!.pages.length - 2) return;

    if (state.userData != null &&
        state.userData!.chaptersRead.contains(state.translation!.chapterId)) {
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

    //Vertical Reading
    if (chapterState.verticalReading) {
      return Scaffold(
        body: Stack(
          children: [
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapterState.translation!.mangaName,
                          style: const TextStyle(fontSize: 17),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Chapter #${chapterState.translation!.chapterNumber}',
                          style: const TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    actions: [
                      if (MediaQuery.of(context).size.width > 350)
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
                        width: 8,
                      ),
                      chapterState.userData == null ||
                              !chapterState.userData!.chaptersRead
                                  .contains(chapterId)
                          ? IconButton(
                              onPressed: () {
                                functions.readChapter();
                              },
                              tooltip: 'Not Watched',
                              icon: const Icon(Icons.visibility))
                          : IconButton(
                              onPressed: () {
                                functions.unreadChapter();
                              },
                              tooltip: 'Already Seen',
                              icon: const Icon(Icons.done)),
                      IconButton(
                          onPressed: () {
                            functions.rotateReading();
                          },
                          tooltip: 'Rotate',
                          icon: const Icon(Icons.screen_rotation_alt)),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  SliverList.builder(
                      itemCount: chapterState.translation!.pages.length,
                      itemBuilder: (context, index) =>
                          ChapterPageWidget(index, functions, chapterState))
                ],
              ),
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
                (chapterState.translation != null &&
                    chapterState.translation!.pages.length - 1 <=
                        chapterState.currentPage)) ...[
              if (chapterState.translation!.previousChapterId != null)
                Positioned(
                  left: 20,
                  bottom: 25,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14),
                    child: FloatingActionButton(
                        heroTag: "back",
                        onPressed: () {
                          navigationKey.currentState?.pushReplacement(
                              PageRouteBuilder(
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          ChapterScreen(
                                              mangaId,
                                              chapterState.translation!
                                                  .previousChapterId!,
                                              chapterState.translation!
                                                  .defaultLanguage)));
                        },
                        child: const Icon(Icons.double_arrow)),
                  ),
                ),
              if (chapterState.translation!.nextChapterId != null)
                Positioned(
                  right: 20,
                  bottom: 25,
                  child: FloatingActionButton(
                      heroTag: "next",
                      onPressed: () {
                        navigationKey.currentState?.pushReplacement(
                            PageRouteBuilder(
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        ChapterScreen(
                                            mangaId,
                                            chapterState
                                                .translation!.nextChapterId!,
                                            chapterState.translation!
                                                .defaultLanguage)));
                      },
                      child: const Icon(
                        Icons.double_arrow,
                      )),
                )
            ]
          ],
        ),
      );
    }

    // TODO : Refactor this
    //Horizontal Reading
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chapterState.translation!.mangaName,
              style: const TextStyle(fontSize: 17),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Chapter #${chapterState.translation!.chapterNumber}',
              style: const TextStyle(fontSize: 14),
            )
          ],
        ),
        actions: [
          if (MediaQuery.of(context).size.width > 350)
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
            width: 8,
          ),
          chapterState.userData == null ||
                  !chapterState.userData!.chaptersRead.contains(chapterId)
              ? IconButton(
                  onPressed: () {
                    functions.readChapter();
                  },
                  tooltip: 'Not Watched',
                  icon: const Icon(Icons.visibility))
              : IconButton(
                  onPressed: () {
                    functions.unreadChapter();
                  },
                  tooltip: 'Already Seen',
                  icon: const Icon(Icons.done)),
          IconButton(
              onPressed: () {
                functions.rotateReading();
              },
              tooltip: 'Rotate',
              icon: const Icon(Icons.screen_rotation_alt)),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: SizedBox(
          width: double.infinity,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: Stack(
              children: [
                PhotoViewGallery.builder(
                  allowImplicitScrolling: false,
                  onPageChanged: (index) async {
                    if (functions.mounted) {
                      await functions.automaticReadChapter(
                          chapterState.translation!.pages[index], 1);
                    }
                  },
                  itemCount: chapterState.translation!.pages.length,
                  builder: (ctx, index) {
                    return PhotoViewGalleryPageOptions(
                      filterQuality: FilterQuality.high,
                      basePosition: Alignment.center,
                      imageProvider: CachedNetworkImageProvider(
                          chapterState.translation!.pages[index],
                          headers: chapterState.translation!.pageHeaders),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                    );
                  },
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: const BoxDecoration(color: Colors.black45),
                      child: Text(
                          "${chapterState.currentPage}/${chapterState.translation!.pages.length}"),
                    )),
                if (chapterState.currentPage == 1 ||
                    (chapterState.translation != null &&
                        chapterState.translation!.pages.length ==
                            chapterState.currentPage)) ...[
                  if (chapterState.translation!.previousChapterId != null)
                    Positioned(
                      left: 20,
                      bottom: 25,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(3.14),
                        child: FloatingActionButton(
                            heroTag: "back",
                            onPressed: () {
                              navigationKey.currentState?.pushReplacement(
                                  PageRouteBuilder(
                                      transitionDuration: Duration.zero,
                                      reverseTransitionDuration: Duration.zero,
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              ChapterScreen(
                                                  mangaId,
                                                  chapterState.translation!
                                                      .previousChapterId!,
                                                  chapterState.translation!
                                                      .defaultLanguage)));
                            },
                            child: const Icon(Icons.double_arrow)),
                      ),
                    ),
                  if (chapterState.translation!.nextChapterId != null)
                    Positioned(
                      right: 20,
                      bottom: 25,
                      child: FloatingActionButton(
                          heroTag: "next",
                          onPressed: () {
                            navigationKey.currentState?.pushReplacement(
                                PageRouteBuilder(
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            ChapterScreen(
                                                mangaId,
                                                chapterState.translation!
                                                    .nextChapterId!,
                                                chapterState.translation!
                                                    .defaultLanguage)));
                          },
                          child: const Icon(
                            Icons.double_arrow,
                          )),
                    )
                ]
              ],
            ),
          )),
    );
  }
}

class ChapterPageWidget extends StatefulWidget {
  final int index;
  final ChapterProfileController controller;
  final ChapterProfileState state;
  const ChapterPageWidget(this.index, this.controller, this.state, {super.key});

  @override
  State<StatefulWidget> createState() => _ChapterPageWidgetState();
}

class _ChapterPageWidgetState extends State<ChapterPageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: 1,
      maxScale: 4,
      key: ValueKey(widget.index),
      child: VisibilityDetector(
        key: Key(widget.state.translation!.pages[widget.index]),
        onVisibilityChanged: (info) async {
          if (widget.controller.mounted) {
            await widget.controller.automaticReadChapter(
                widget.state.translation!.pages[widget.index],
                info.visibleFraction);
          }
        },
        child: CachedNetworkImage(
            errorWidget: (context, url, error) =>
                const CircularProgressIndicator(),
            imageUrl: widget.state.translation!.pages[widget.index],
            width: double.infinity,
            httpHeaders: widget.state.translation!.pageHeaders,
            filterQuality: FilterQuality.high,
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => const SizedBox(
                height: 400,
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()))),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
