// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';

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
      userData: userData ?? this.userData,
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
  }

  Future fetchMangaUserData() async {
    state = state.copyWith(isLoadingUserData: true);
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .getDataByMangaByUser(mangaId, 1);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future changeMangaUserStatus(MangaUserStatusEnum newStatus) async {
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
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .markChapterRead(chapterId);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
  }

  Future unreadChapter(int chapterId) async {
    var userData = await ref
        .watch(mangaUsersRepositoryProvider)
        .unmarkChapterRead(chapterId);
    state = state.copyWith(isLoadingUserData: false, userData: userData);
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
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {}, child: const Icon(Icons.menu_book)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                        sigmaX: 10.0, sigmaY: 10.0, tileMode: TileMode.clamp),
                    child: CachedNetworkImage(
                        imageUrl: mangaState.manga!.imageUrl,
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
                                imageUrl: mangaState.manga!.imageUrl,
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fitWidth,
                                height: 230,
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //TODO: Check If has UserStatus or not
                              if (!mangaState.isLoadingUserData)
                                MangaUserStatusSection(
                                    mangaState.manga!,
                                    mangaState.userData!,
                                    functions.changeMangaUserStatus),
                              MangaDetailsSection(mangaState.manga!),
                              if (!mangaState.isLoadingUserData)
                                MangaChaptersSection(
                                    mangaState.manga!,
                                    mangaState.userData!,
                                    mangaState.selectedLanguage,
                                    functions.changeSelectedLanguage,
                                    functions.readChapter,
                                    functions.unreadChapter)
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
    );
  }
}

class MangaUserStatusSection extends StatelessWidget {
  final Manga manga;
  final MangaUserData userData;
  final Future Function(MangaUserStatusEnum) changeStatus;
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
        DropdownButtonFormField(
            value: userData.status,
            isExpanded: true,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
            ),
            items: MangaUserStatusEnum.values
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ))
                .toList(),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onChanged: (value) async {
              await changeStatus(value!);
            }),
        const SizedBox(
          height: 10,
        ),
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
              value: userData.chaptersRead / manga.chapters.length,
              color: Theme.of(context).primaryColor,
              backgroundColor: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
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
  final Manga manga;
  final MangaUserData userData;
  final TranslationLanguageEnum selectedLanguage;
  final void Function(TranslationLanguageEnum) changeSelectedLanguage;
  final Future Function(int) markChapterRead;
  final Future Function(int) unmarkChapterRead;
  const MangaChaptersSection(this.manga, this.userData, this.selectedLanguage,
      this.changeSelectedLanguage, this.markChapterRead, this.unmarkChapterRead,
      {super.key});

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
              '(${userData.chaptersRead}/${manga.chapters.where((c) => c.translations.any((t) => t.language == selectedLanguage)).length})',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                changeSelectedLanguage(TranslationLanguageEnum.EN);
              },
              child: Container(
                width: 30,
                height: 20,
                decoration: selectedLanguage == TranslationLanguageEnum.EN
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
                changeSelectedLanguage(TranslationLanguageEnum.PT);
              },
              child: Container(
                width: 30,
                height: 20,
                decoration: selectedLanguage == TranslationLanguageEnum.PT
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
        Wrap(
          runSpacing: 10,
          spacing: 10,
          children: manga.chapters
              .where((c) =>
                  c.translations.any((t) => t.language == selectedLanguage))
              .map(
                (e) => InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () {},
                  child: Container(
                    width: 55,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(child: Text(e.name)),
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
