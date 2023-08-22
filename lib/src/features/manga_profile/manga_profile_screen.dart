// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_type_enum.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/roles_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state_provider.dart';
import 'package:shounengaming_mangas_mobile/src/features/chapter/chapter_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_sources_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/tags/tag_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';
import 'package:shounengaming_mangas_mobile/src/others/enums_translation.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

import 'manga_profile_provider.dart';
import 'manga_profile_state.dart';

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
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  await functions.fetchNewChapters();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text(
                      'Update for Chapters started',
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
          if (ref.watch(appStateProvider).loggedUser!.role != RolesEnum.USER)
            IconButton(
                onPressed: () async {
                  await navigationKey.currentState?.push(MaterialPageRoute(
                      builder: (context) =>
                          MangaSourcesScreen(mangaState.manga!.id)));
                },
                icon: const Icon(Icons.edit))
        ],
      ),
      floatingActionButton:
          mangaState.nextChapterId != -1 && !mangaState.isLoadingUserData
              ? RawMaterialButton(
                  onPressed: () async {
                    await navigationKey.currentState?.push(MaterialPageRoute(
                        builder: (context) => ChapterScreen(
                            mangaState.manga!.id,
                            mangaState.nextChapterId,
                            mangaState.selectedLanguage)));

                    await functions.fetchMangaUserData();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: palette[3])),
                  elevation: 4,
                  fillColor: palette[0],
                  hoverColor: palette[1],
                  splashColor: palette[2],
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    minWidth: 150,
                    maxHeight: 50,
                    maxWidth: 150,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.menu_book),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Next Chapter',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            'Chapter #${mangaState.manga!.chapters.firstWhere((element) => element.id == mangaState.nextChapterId).name}',
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : null,
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
                                          functions.changeMangaUserStatus,
                                          functions.changeMangaUserRating)
                                      : const SizedBox(
                                          height: 130,
                                          width: double.infinity,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator())),
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
  final Future Function(double) changeRating;
  const MangaUserStatusSection(
      this.manga, this.userData, this.changeStatus, this.changeRating,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 4,
        ),
        Center(
          child: RatingBar.builder(
            initialRating: userData?.rating ?? 0,
            minRating: 0,
            itemSize: 30,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) async {
              await changeRating(rating);
            },
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          'Status',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        DropdownButtonFormField<MangaUserStatusEnum?>(
            value: userData?.status,
            isExpanded: true,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero)),
            ),
            items: [
              if (userData?.chaptersRead.isEmpty ?? true) null,
              ...MangaUserStatusEnum.values
            ]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        translateMangaStatus(e),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ))
                .toList(),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            onChanged: (value) async {
              await changeStatus(value);
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
                color: palette[1],
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
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 26, fontWeight: FontWeight.w600),
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
            style:
                Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 16),
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
                            color: palette[0],
                            borderRadius: BorderRadius.circular(8)),
                        child: InkWell(
                          onTap: () {
                            navigationKey.currentState?.push(
                              MaterialPageRoute(
                                  builder: (context) => TagScreen(e)),
                            );
                          },
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
    var titleStyle = Theme.of(context)
        .textTheme
        .titleSmall
        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Synopsis', style: titleStyle),
        const SizedBox(
          height: 4,
        ),
        ReadMoreText(
          manga.description,
          trimLength: 500,
          trimCollapsedText: ' Show More',
          trimExpandedText: ' Show Less',
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text('Score', style: titleStyle),
        const SizedBox(
          height: 4,
        ),
        Text(
          "${manga.averageScore.toStringAsFixed(2)} / 10",
        ),
        const SizedBox(
          height: 16,
        ),
        Text('Type', style: titleStyle),
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
        Text('Status', style: titleStyle),
        const SizedBox(
          height: 4,
        ),
        Text(
          manga.isReleasing ? 'Releasing' : 'Completed',
        ),
        const SizedBox(
          height: 16,
        ),
        Text('Published', style: titleStyle),
        const SizedBox(
          height: 4,
        ),
        Text(
          '${manga.startedAt != null ? DateFormat("dd MMM yyyy").format(manga.startedAt!) : "?"} - ${manga.finishedAt != null ? DateFormat("dd MMM yyyy").format(manga.finishedAt!) : "?"}',
        ),
        const SizedBox(
          height: 16,
        ),
        Text('Writer', style: titleStyle),
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
              '(${mangaState.manga?.chapters.where((c) => c.translations.any((t) => t.language == mangaState.selectedLanguage)).where((element) => mangaState.userData?.chaptersRead.contains(element.id) ?? false).length ?? 0}/${mangaState.manga!.chapters.where((c) => c.translations.any((t) => t.language == mangaState.selectedLanguage)).length})',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                controller.revertChaptersList();
              },
              child: Icon(mangaState.listInverted
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_up),
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
          physics: const NeverScrollableScrollPhysics(),
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
                              ? Colors.green[800]
                              : palette[1],
                          border: Border.all(color: palette[2]),
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
