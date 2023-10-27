// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state.providers.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/double_tappable_interactive_viewer.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/enums_translation.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/sliding_app_bar.dart';

import '../providers/chapter.providers.dart';
import '../providers/chapter_profile_controller.dart';
import '../providers/chapter_screen_parameters.dart';
import '../providers/chapter_state.dart';

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
