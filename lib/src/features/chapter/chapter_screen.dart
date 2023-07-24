// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/reading_mode_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_translation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/others/double_tappable_interactive_viewer.dart';
import 'package:shounengaming_mangas_mobile/src/others/enums_translation.dart';
import 'package:shounengaming_mangas_mobile/src/others/sliding_app_bar.dart';

const String _localStorageKey = "chapter_progress_";

enum ReadingDirectionEnum { VERTICAL, VERTICAL_PAGED, HORIZONTAL_PAGED }

class ChapterReadingProgress {
  int chapterId;
  TranslationLanguageEnum language;
  int page;
  ChapterReadingProgress({
    required this.chapterId,
    required this.language,
    required this.page,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chapterId': chapterId,
      'language': language.name,
      'page': page,
    };
  }

  factory ChapterReadingProgress.fromMap(Map<String, dynamic> map) {
    return ChapterReadingProgress(
      chapterId: map['chapterId'] as int,
      language: TranslationLanguageEnum.values.byName(map['language']),
      page: map['page'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterReadingProgress.fromJson(String source) =>
      ChapterReadingProgress.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

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
        .getString("$_localStorageKey${state.translation!.chapterId}");
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
    String? lastPagesProgressString = sharedPrefs
        .getString("$_localStorageKey${state.translation!.chapterId}");

    ChapterReadingProgress? lastPagesProgress = lastPagesProgressString == null
        ? null
        : ChapterReadingProgress.fromJson(lastPagesProgressString);

    var isLastPage = state.currentPage == state.translation!.pages.length;
    if (isLastPage) {
      // Show Bar
      state = state.copyWith(showingAppBar: true);

      // Delete from Local Storage
      await sharedPrefs
          .remove("$_localStorageKey${state.translation!.chapterId}");
    } else {
      //Save in SharedPreferences
      lastPagesProgress = ChapterReadingProgress(
          chapterId: state.translation!.chapterId,
          language: state.translation!.language,
          page: currentPage);
      await sharedPrefs.setString(
          "$_localStorageKey${state.translation!.chapterId}",
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

class ChapterScreen extends ConsumerStatefulWidget {
  final int mangaId;
  final int chapterId;
  final TranslationLanguageEnum language;
  const ChapterScreen(this.mangaId, this.chapterId, this.language, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends ConsumerState<ChapterScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var chapterState = ref.watch(chapterProfileProvider(ChapterScreenParameters(
        mangaId: widget.mangaId,
        chapterId: widget.chapterId,
        language: widget.language)));
    var functions = ref.read(chapterProfileProvider(ChapterScreenParameters(
            mangaId: widget.mangaId,
            chapterId: widget.chapterId,
            language: widget.language))
        .notifier);

    if (chapterState.isLoadingTranslation) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    var configs = ref.watch(appStateProvider).userConfigs;
    var canSkipTranslation = configs?.skipChapterToAnotherTranslation ?? true;

    var nextLanguage = canSkipTranslation
        ? configs?.translationLanguage
        : chapterState.translation?.language;

    return Scaffold(
      extendBodyBehindAppBar:
          chapterState.readingMode == ReadingDirectionEnum.VERTICAL,
      appBar: chapterState.readingMode == ReadingDirectionEnum.VERTICAL
          ? SlidingAppBar(
              controller: _controller,
              visible: chapterState.showingAppBar,
              child: _buildAppBar(chapterState, functions),
            )
          : _buildAppBar(chapterState, functions),
      body: GestureDetector(
        onTapDown: (details) {
          functions.changeAppBarVisibility();
        },
        child: Stack(
          children: [
            chapterState.readingMode == ReadingDirectionEnum.VERTICAL
                ? RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(chapterProfileProvider(
                          ChapterScreenParameters(
                              mangaId: widget.mangaId,
                              chapterId: widget.chapterId,
                              language: widget.language)));
                    },
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: ScrollablePositionedList.builder(
                          key: const ValueKey('list'),
                          addAutomaticKeepAlives: true,
                          physics: const BouncingScrollPhysics(),
                          itemScrollController:
                              functions.scrollVerticalController,
                          itemPositionsListener:
                              functions.scrollVerticalItemsListener,
                          scrollOffsetListener:
                              functions.scrollVerticalListener,
                          itemCount: chapterState.translation!.pages.length,
                          itemBuilder: (context, index) => ChapterPageWidget(
                              index, functions, chapterState)),
                    ),
                  )
                : PhotoViewGallery.builder(
                    allowImplicitScrolling: false,
                    pageController: functions.scrollController,
                    onPageChanged: (index) async {
                      if (functions.mounted) {
                        await functions.automaticReadChapter(
                            chapterState.translation!.pages[index], 100, true);
                      }
                    },
                    scrollDirection: chapterState.readingMode ==
                            ReadingDirectionEnum.VERTICAL_PAGED
                        ? Axis.vertical
                        : Axis.horizontal,
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
            //-------------------------------------------------
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
            if (functions.shouldShowButtons()) ...[
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
                                              widget.mangaId,
                                              chapterState.translation!
                                                  .previousChapterId!,
                                              nextLanguage!)));
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
                                pageBuilder: (context, animation1,
                                        animation2) =>
                                    ChapterScreen(
                                        widget.mangaId,
                                        chapterState
                                            .translation!.nextChapterId!,
                                        nextLanguage!)));
                      },
                      child: const Icon(
                        Icons.double_arrow,
                      )),
                ),
            ],
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      ChapterProfileState chapterState, ChapterProfileController functions) {
    return AppBar(
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
                    .contains(chapterState.translation?.chapterId)
            ? IconButton(
                onPressed: () async {
                  var success = await functions.readChapter();
                  fToast.showToast(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.black87,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(success
                              ? 'Chapter Seen'
                              : "Error seeing chapter"),
                        ],
                      ),
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(milliseconds: 1600),
                  );
                },
                tooltip: 'Not Watched',
                icon: const Icon(Icons.visibility))
            : IconButton(
                onPressed: () async {
                  var success = await functions.unreadChapter();
                  fToast.showToast(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.black87,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(success
                              ? 'Chapter not Seen'
                              : "Error unseeing chapter"),
                        ],
                      ),
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(milliseconds: 1600),
                  );
                },
                tooltip: 'Already Seen',
                icon: const Icon(Icons.done)),
        IconButton(
            onPressed: () async {
              var readingMode = await functions.rotateReading();
              fToast.showToast(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.black87,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(translateReadingMode(readingMode)),
                    ],
                  ),
                ),
                gravity: ToastGravity.BOTTOM,
                toastDuration: const Duration(milliseconds: 1600),
              );
            },
            tooltip: 'Rotate',
            icon: const Icon(Icons.screen_rotation_alt)),
        const SizedBox(
          width: 10,
        )
      ],
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
    return DoubleTappableInteractiveViewer(
      scaleDuration: const Duration(milliseconds: 600),
      key: ValueKey(widget.index),
      child: VisibilityDetector(
        key: Key(widget.state.translation!.pages[widget.index]),
        onVisibilityChanged: (info) async {
          if (widget.controller.mounted) {
            await widget.controller.automaticReadChapter(
                widget.state.translation!.pages[widget.index],
                info.visibleFraction,
                false);
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
