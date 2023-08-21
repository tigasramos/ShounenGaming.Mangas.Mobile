import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state_provider.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/constants.dart';
import 'package:shounengaming_mangas_mobile/src/others/shared_components/manga_image.dart';

enum CompletedOrderByEnum { alphabetical, completedDate }

final orderReadingProvider = StateProvider.autoDispose<CompletedOrderByEnum?>(
  (ref) => null,
);
final orderASCReadingProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);

final completedMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id,
      MangaUserStatusEnum.COMPLETED);
});

final filteredCompletedMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderReadingProvider);
  var orderASCFilter = ref.watch(orderASCReadingProvider);
  var completedMangas = ref.watch(completedMangasProvider).asData?.value ?? [];

  // Default Order be Last Completed Desc
  if (orderFilter == null) {
    orderFilter = CompletedOrderByEnum.completedDate;
    orderASCFilter = false;
  }
  switch (orderFilter) {
    case CompletedOrderByEnum.alphabetical:
      return completedMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case CompletedOrderByEnum.completedDate:
      return completedMangas
        ..sort((a, b) =>
            (a.addedToStatusDate == null
                ? 0
                : b.addedToStatusDate == null
                    ? 1
                    : a.addedToStatusDate!.compareTo(b.addedToStatusDate!)) *
            (orderASCFilter ? 1 : -1));

    default:
      return completedMangas;
  }
});

class LibraryCompletedScreen extends ConsumerWidget {
  const LibraryCompletedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          height: 50,
          color: Theme.of(context)
              .scaffoldBackgroundColor
              .withBlue(35)
              .withRed(30),
          child: Row(children: [
            Expanded(
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.filter_alt))),
            Expanded(
                flex: 4,
                child: Center(
                    child: Text(
                        '${ref.watch(filteredCompletedMangasProvider).length} Mangas'))),
            Expanded(
              child: PopupMenuButton(
                tooltip: 'Order By',
                initialValue: ref.watch(orderReadingProvider),
                onSelected: (selected) {
                  if (ref.read(orderReadingProvider) == selected) {
                    //If selects the same and is Desc, clears order by
                    if (!ref.watch(orderASCReadingProvider)) {
                      ref.watch(orderReadingProvider.notifier).state = null;
                      ref.watch(orderASCReadingProvider.notifier).state = true;
                    }
                    // If select the same and its asc, goes desc
                    else {
                      ref.watch(orderASCReadingProvider.notifier).state =
                          !ref.watch(orderASCReadingProvider);
                    }
                  }
                  // If not the same changes and goes asc
                  else {
                    ref.watch(orderReadingProvider.notifier).state = selected;
                    ref.watch(orderASCReadingProvider.notifier).state = true;
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: CompletedOrderByEnum.alphabetical,
                    child: Row(
                      children: [
                        const Text('Alphabetical'),
                        const Spacer(),
                        if (ref.watch(orderReadingProvider) ==
                            CompletedOrderByEnum.alphabetical)
                          Icon(ref.watch(orderASCReadingProvider)
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: CompletedOrderByEnum.completedDate,
                    child: Row(
                      children: [
                        const Text('Completed At'),
                        const Spacer(),
                        if (ref.watch(orderReadingProvider) ==
                            CompletedOrderByEnum.completedDate)
                          Icon(ref.watch(orderASCReadingProvider)
                              ? Icons.arrow_upward
                              : Icons.arrow_downward)
                      ],
                    ),
                  ),
                ],
                child: const Icon(Icons.sort),
              ),
            ),
          ]),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0;
                    i < ref.watch(filteredCompletedMangasProvider).length;
                    i++)
                  LibraryCompletedMangaTile(i)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LibraryCompletedMangaTile extends ConsumerWidget {
  final int index;
  const LibraryCompletedMangaTile(this.index, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mangaUserData = ref.watch(filteredCompletedMangasProvider)[index];
    return InkWell(
      onTap: () async {
        await navigationKey.currentState?.push(
          MaterialPageRoute(
              builder: (context) => MangaProfileScreen(mangaUserData.manga.id)),
        );
        ref.invalidate(completedMangasProvider);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            MangaImage(mangaUserData.manga.imagesUrls[0],
                isNSFW: mangaUserData.manga.isNSFW),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    mangaUserData.manga.name,
                    minFontSize: 16,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  Text(
                    '${mangaUserData.manga.type.name}, ${mangaUserData.manga.startedAt?.year ?? "?"}-${mangaUserData.manga.finishedAt?.year ?? "?"}',
                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (mangaUserData.manga.myAnimeListId != null) ...[
                        GestureDetector(
                          onTap: () async {
                            try {
                              await launch(
                                'https://myanimelist.net/manga/${mangaUserData.manga.myAnimeListId}',
                                customTabsOption: CustomTabsOption(
                                  toolbarColor: Theme.of(context).primaryColor,
                                  enableDefaultShare: true,
                                  enableUrlBarHiding: true,
                                  showPageTitle: true,
                                ),
                                safariVCOption: SafariViewControllerOption(
                                  preferredBarTintColor:
                                      Theme.of(context).primaryColor,
                                  preferredControlTintColor: Colors.white,
                                  barCollapsingEnabled: true,
                                  entersReaderIfAvailable: false,
                                  dismissButtonStyle:
                                      SafariViewControllerDismissButtonStyle
                                          .close,
                                ),
                              );
                            } catch (e, stackTrace) {
                              await Sentry.captureException(e,
                                  stackTrace: stackTrace);
                              debugPrint(e.toString());
                            }
                          },
                          child: Image.asset(
                            "assets/images/sources/mal_icon.png",
                            height: 25,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      if (mangaUserData.manga.anilistId != null)
                        GestureDetector(
                          onTap: () async {
                            try {
                              await launch(
                                'https://anilist.co/manga/${mangaUserData.manga.anilistId}',
                                customTabsOption: CustomTabsOption(
                                  toolbarColor: Theme.of(context).primaryColor,
                                  enableDefaultShare: true,
                                  enableUrlBarHiding: true,
                                  showPageTitle: true,
                                ),
                                safariVCOption: SafariViewControllerOption(
                                  preferredBarTintColor:
                                      Theme.of(context).primaryColor,
                                  preferredControlTintColor: Colors.white,
                                  barCollapsingEnabled: true,
                                  entersReaderIfAvailable: false,
                                  dismissButtonStyle:
                                      SafariViewControllerDismissButtonStyle
                                          .close,
                                ),
                              );
                            } catch (e, stackTrace) {
                              await Sentry.captureException(e,
                                  stackTrace: stackTrace);
                              debugPrint(e.toString());
                            }
                          },
                          child: Image.asset(
                            "assets/images/sources/al_icon.png",
                            height: 25,
                          ),
                        ),
                      const Spacer(),
                      Text(
                        'Completed At: ',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 9, color: Colors.white70),
                      ),
                      Text(
                        mangaUserData.addedToStatusDate != null
                            ? DateFormat("dd MMM yyyy")
                                .format(mangaUserData.addedToStatusDate!)
                            : "Not Found",
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: 11,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}
