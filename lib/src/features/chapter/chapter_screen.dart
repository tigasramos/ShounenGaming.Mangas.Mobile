import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_translation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';

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

  bool isLoadingUserData;
  bool isLoadingTranslation;

  ChapterProfileState({
    this.translation,
    this.userData,
    this.isLoadingTranslation = true,
    this.isLoadingUserData = true,
  });
  @override
  String toString() {
    return '($isLoadingTranslation, $isLoadingUserData, $translation, $userData)';
  }

  ChapterProfileState copyWith({
    MangaTranslation? translation,
    MangaUserData? userData,
    bool? isLoadingTranslation,
    bool? isLoadingUserData,
  }) {
    return ChapterProfileState(
      translation: translation ?? this.translation,
      userData: userData ?? this.userData,
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
    // var functions = ref
    //     .read(chapterProfileProvider([mangaId, chapterId, language]).notifier);
    print('Rebuilt');
    print(chapterState.toString());

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
            width: 6,
          ),
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
          child: SingleChildScrollView(
            child: Column(
                children: chapterState.translation!.pages
                    .map((e) => InteractiveViewer(
                          child: CachedNetworkImage(
                              imageUrl: e,
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fitWidth,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator()),
                        ))
                    .toList()),
          )),
    );
  }
}
