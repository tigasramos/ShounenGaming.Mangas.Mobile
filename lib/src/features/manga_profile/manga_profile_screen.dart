// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_type_enum.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/roles_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/chapter/chapter_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_sources_screen.dart';

final mangaProfileProvider = StateNotifierProvider.family
    .autoDispose<MangaProfileController, MangaProfileState, int>(
        (ref, id) => MangaProfileController(ref, id));

class MangaProfileState {
  Manga? manga;
  MangaUserData? userData;

  TranslationLanguageEnum selectedLanguage;

  bool isLoadingManga;
  bool isLoadingUserData;
  bool isLoading() => isLoadingManga || isLoadingUserData;
  MangaProfileState({
    this.manga,
    this.userData,
    this.selectedLanguage = TranslationLanguageEnum.PT,
    this.isLoadingManga = true,
    this.isLoadingUserData = true,
  });

  MangaProfileState copyWith({
    Manga? manga,
    MangaUserData? userData,
    TranslationLanguageEnum? selectedLanguage,
    bool? isLoadingManga,
    bool? isLoadingUserData,
  }) {
    return MangaProfileState(
      manga: manga ?? this.manga,
      userData: isLoadingUserData != null && !isLoadingUserData
          ? userData
          : (userData ?? this.userData),
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isLoadingManga: isLoadingManga ?? this.isLoadingManga,
      isLoadingUserData: isLoadingUserData ?? this.isLoadingUserData,
    );
  }
}

class MangaProfileController extends StateNotifier<MangaProfileState> {
  MangaProfileController(this.ref, this.mangaId) : super(MangaProfileState()) {
    fetchMangaInfo();
    fetchMangaUserData();
  }

  Ref ref;
  int mangaId;

  Future fetchMangaInfo() async {
    state = state.copyWith(isLoadingManga: true);
    var manga = await ref.watch(mangaRepositoryProvider).getMangaById(mangaId);
    state = state.copyWith(isLoadingManga: false, manga: manga);

    if (!manga.chapters.any((c) =>
        c.translations.any((t) => t.language == TranslationLanguageEnum.PT))) {
      state = state.copyWith(selectedLanguage: TranslationLanguageEnum.EN);
    }
  }

  Future fetchMangaUserData() async {
    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .getDataByMangaByUser(
            mangaId, ref.watch(appStateProvider).loggedUser!.id);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future changeMangaUserStatus(MangaUserStatusEnum? newStatus) async {
    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .updateMangaStatusByUser(mangaId, newStatus);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  void changeSelectedLanguage(TranslationLanguageEnum language) async {
    state = state.copyWith(selectedLanguage: language);
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
  }

  Future readUntilChapter(int chapterId) async {
    if (state.manga == null) return;
    state = state.copyWith(isLoadingUserData: true);

    var userData = state.userData;
    var reversedList = state.manga!.chapters.toList().reversed;

    var chaptersIds = <int>[];
    for (var chapter in reversedList) {
      if (!userData!.chaptersRead.contains(chapter.id)) {
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
  }

  Future unreadUntilChapter(int chapterId) async {
    if (state.manga == null || state.userData == null) return;
    state = state.copyWith(isLoadingUserData: true);
    var userData = state.userData;

    var chaptersIds = <int>[];
    for (var chapter in state.manga!.chapters) {
      if (userData!.chaptersRead.contains(chapter.id)) {
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
  }

  Future fetchNewChapters() async {
    var repo = ref.watch(mangaRepositoryProvider);
    await repo.fetchChaptersForManga(mangaId);
  }
}

class MangaProfileScreen extends ConsumerWidget {
  final int mangaId;
  const MangaProfileScreen(this.mangaId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mangaState = ref.watch(mangaProfileProvider(mangaId));
    var functions = ref.read(mangaProfileProvider(mangaId).notifier);

    if (mangaState.isLoadingManga) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: ref.watch(appStateProvider).loggedUser!.role == RolesEnum.USER
            ? []
            : [
                IconButton(
                    onPressed: () async {
                      try {
                        await functions.fetchNewChapters();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            'Update for Chapters started!',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green[700],
                          duration: const Duration(seconds: 2),
                        ));
                      } on Exception catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Error: $e',
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red[400],
                          duration: const Duration(seconds: 3),
                        ));
                      }
                    },
                    icon: const Icon(Icons.refresh)),
                IconButton(
                    onPressed: () async {
                      await navigationKey.currentState?.push(MaterialPageRoute(
                          builder: (context) =>
                              MangaSourcesScreen(mangaState.manga!.id)));
                    },
                    icon: const Icon(Icons.edit))
              ],
      ),
      // floatingActionButtonLocation: ExpandableFab.location,
      // floatingActionButton: ExpandableFab(
      //   children: [
      //     FloatingActionButton.extended(
      //       heroTag: null,
      //       tooltip: 'Read Next Chapter',
      //       label: const Icon(Icons.menu_book),
      //       onPressed: () {},
      //     ),
      //     FloatingActionButton.extended(
      //       tooltip: 'See All Chapters',
      //       heroTag: null,
      //       label: const Icon(Icons.remove_red_eye),
      //       onPressed: () {},
      //     ),
      //     FloatingActionButton.extended(
      //       heroTag: null,
      //       tooltip: 'Make Private',
      //       label: const Icon(Icons.lock),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (mangaState.isLoadingUserData) return;

            //Calculate next Chapter to read
            var nextChapterId = -1;
            var chaptersNotRead = mangaState.manga!.chapters
                .where((element) => element.translations
                    .any((t) => t.language == mangaState.selectedLanguage))
                .toList()
              ..removeWhere((element) =>
                  mangaState.userData!.chaptersRead.contains(element.id));
            if (chaptersNotRead.isEmpty) {
              nextChapterId = mangaState.manga!.chapters.first.id;
            } else {
              nextChapterId = chaptersNotRead.last.id;
            }

            if (nextChapterId == -1) return;

            await navigationKey.currentState?.push(MaterialPageRoute(
                builder: (context) => ChapterScreen(mangaState.manga!.id,
                    nextChapterId, mangaState.selectedLanguage)));

            await functions.fetchMangaUserData();
          },
          child: const Icon(Icons.menu_book)),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            await functions.fetchMangaInfo();
            await functions.fetchMangaUserData();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                            sigmaX: 10.0,
                            sigmaY: 10.0,
                            tileMode: TileMode.clamp),
                        child: CachedNetworkImage(
                            imageUrl: mangaState.manga!.imagesUrls[0],
                            errorWidget: (context, url, error) =>
                                const CircularProgressIndicator(),
                            fit: BoxFit.fitWidth,
                            height: 300,
                            width: double.infinity,
                            alignment: Alignment.center),
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                            Theme.of(context).scaffoldBackgroundColor,
                            Colors.transparent
                          ],
                              begin: Alignment.bottomCenter,
                              //stops: [0.1, 0.7],
                              end: Alignment.center)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 110,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6)),
                                  child: CachedNetworkImage(
                                    imageUrl: mangaState.manga!.imagesUrls[0],
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.fitWidth,
                                    height: 230,
                                    errorWidget: (context, url, error) =>
                                        const CircularProgressIndicator(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MangaBasicInfoSection(mangaState.manga!)
                              ],
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //TODO: Check If has UserStatus or not
                                  !mangaState.isLoadingUserData
                                      ? MangaUserStatusSection(
                                          mangaState.manga!,
                                          mangaState.userData,
                                          functions.changeMangaUserStatus)
                                      : const SizedBox(
                                          height: 130,
                                          child: CircularProgressIndicator()),
                                  MangaDetailsSection(mangaState.manga!),

                                  MangaChaptersSection(mangaState, functions)
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MangaUserStatusSection extends StatelessWidget {
  final Manga manga;
  final MangaUserData? userData;
  final Future Function(MangaUserStatusEnum?) changeStatus;
  const MangaUserStatusSection(this.manga, this.userData, this.changeStatus,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownButtonFormField<String>(
            value: userData?.status.name ?? "",
            isExpanded: true,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
            ),
            items: [
              if (userData?.chaptersRead.isEmpty ?? true) "",
              ...MangaUserStatusEnum.values.map((e) => e.name)
            ]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ))
                .toList(),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onChanged: (value) async {
              if (value == null) return;
              await changeStatus(value != ""
                  ? MangaUserStatusEnum.values.byName(value)
                  : null);
            }),
        const SizedBox(
          height: 10,
        ),
        if (manga.chapters.isNotEmpty) ...[
          Text(
            'Progress',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            child: LinearProgressIndicator(
                minHeight: 8,
                value: (userData?.chaptersRead.length ?? 0) /
                    manga.chapters.length,
                color: Theme.of(context).primaryColor,
                backgroundColor: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ],
    );
  }
}

class MangaBasicInfoSection extends StatelessWidget {
  final Manga manga;
  const MangaBasicInfoSection(this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Tooltip(
            message: manga.name,
            child: Text(
              manga.name,
              maxLines: 2,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
          ),
          AutoSizeText(
            manga.alternativeNames
                .where((element) =>
                    element.id != "Default" && element.id != "Synonym")
                .map((e) => e.value)
                .join(", "),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: manga.tags
                  .map((e) => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            e,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class MangaDetailsSection extends StatelessWidget {
  final Manga manga;
  const MangaDetailsSection(this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Synopsis',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          manga.description,
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Score',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          "${manga.averageScore.toStringAsFixed(2)} / 10",
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 4,
            ),
            CountryFlag(
                height: 13,
                country: manga.type == MangaTypeEnum.MANGA
                    ? Country.jp
                    : (manga.type == MangaTypeEnum.MANHUA
                        ? Country.cn
                        : Country.kr)),
            const SizedBox(
              width: 10,
            ),
            Text(
              manga.type.name,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Status',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          manga.isReleasing ? 'Releasing' : 'Completed',
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Published',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          '${manga.startedAt != null ? DateFormat("dd MMM yyyy").format(manga.startedAt!) : "?"} - ${manga.finishedAt != null ? DateFormat("dd MMM yyyy").format(manga.finishedAt!) : "?"}',
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          'Writer',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            manga.writer.name,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

class MangaChaptersSection extends StatelessWidget {
  // final Manga manga;
  // final MangaUserData? userData;
  // final TranslationLanguageEnum selectedLanguage;
  // final void Function(TranslationLanguageEnum) changeSelectedLanguage;
  // final Future Function() updateMangaUserData;

  final MangaProfileState mangaState;
  final MangaProfileController controller;

  const MangaChaptersSection(this.mangaState, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Chapters',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '(${mangaState.userData?.chaptersRead.length ?? 0}/${mangaState.manga!.chapters.where((c) => c.translations.any((t) => t.language == mangaState.selectedLanguage)).length})',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                controller.changeSelectedLanguage(TranslationLanguageEnum.EN);
              },
              child: Container(
                width: 30,
                height: 20,
                decoration:
                    mangaState.selectedLanguage == TranslationLanguageEnum.EN
                        ? BoxDecoration(border: Border.all(color: Colors.white))
                        : null,
                child: CountryFlag(
                  country: Country.gb,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                controller.changeSelectedLanguage(TranslationLanguageEnum.PT);
              },
              child: Container(
                width: 30,
                height: 20,
                decoration:
                    mangaState.selectedLanguage == TranslationLanguageEnum.PT
                        ? BoxDecoration(border: Border.all(color: Colors.white))
                        : null,
                child: CountryFlag(
                  country: Country.pt,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        GridView.count(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          crossAxisCount: MediaQuery.of(context).size.width ~/ 70,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 55 / 35,
          children: mangaState.manga!.chapters
              .where((c) => c.translations
                  .any((t) => t.language == mangaState.selectedLanguage))
              .map(
                (e) => FocusedMenuHolder(
                  menuWidth: 140,
                  menuOffset: 0,
                  menuItemExtent: 50,
                  menuBoxDecoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  onPressed: () {},
                  menuItems: [
                    FocusedMenuItem(
                        title: const Text('Read/Unread'),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        onPressed: () async {
                          if (mangaState.userData != null &&
                              mangaState.userData!.chaptersRead
                                  .contains(e.id)) {
                            await controller.unreadChapter(e.id);
                          } else {
                            await controller.readChapter(e.id);
                          }
                        }),
                    FocusedMenuItem(
                        title: const Text('Read Until This'),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        onPressed: () async {
                          await controller.readUntilChapter(e.id);
                        }),
                    FocusedMenuItem(
                        title: const Text('Unread Until This'),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        onPressed: () async {
                          await controller.unreadUntilChapter(e.id);
                        })
                  ],
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () async {
                      await navigationKey.currentState?.push(MaterialPageRoute(
                          builder: (context) => ChapterScreen(
                              mangaState.manga!.id,
                              e.id,
                              mangaState.selectedLanguage)));

                      await controller.fetchMangaUserData();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: mangaState.userData != null &&
                                  mangaState.userData!.chaptersRead
                                      .contains(e.id)
                              ? Colors.green[700]
                              : Colors.purple,
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Text(e.name.toString())),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(
          height: 70,
        )
      ],
    );
  }
}
