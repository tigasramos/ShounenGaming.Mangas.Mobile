import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state.providers.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';

import 'library_filters.dart';

// Completed
final orderCompletedProvider = StateProvider.autoDispose<CompletedOrderByEnum?>(
  (ref) => CompletedOrderByEnum.completedDate,
);
final orderASCCompletedProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
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
  var orderFilter = ref.watch(orderCompletedProvider);
  var orderASCFilter = ref.watch(orderASCCompletedProvider);
  var completedMangas = ref.watch(completedMangasProvider).asData?.value ?? [];

  switch (orderFilter) {
    case CompletedOrderByEnum.alphabetical:
      return completedMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case CompletedOrderByEnum.rating:
      return completedMangas
        ..sort((a, b) =>
            (a.rating ?? 0).compareTo(b.rating ?? 0) *
            (orderASCFilter ? 1 : -1));
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

// Dropped
final orderDroppedProvider = StateProvider.autoDispose<DroppedOrderByEnum?>(
  (ref) => null,
);
final orderASCDroppedProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);

final droppedMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id, MangaUserStatusEnum.DROPPED);
});

final filteredDroppedMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderDroppedProvider);
  var orderASCFilter = ref.watch(orderASCDroppedProvider);
  var droppedMangas = ref.watch(droppedMangasProvider).asData?.value ?? [];

  switch (orderFilter) {
    case DroppedOrderByEnum.alphabetical:
      return droppedMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case DroppedOrderByEnum.droppedDate:
      return droppedMangas
        ..sort((a, b) =>
            (a.addedToStatusDate == null
                ? 0
                : b.addedToStatusDate == null
                    ? 1
                    : a.addedToStatusDate!.compareTo(b.addedToStatusDate!)) *
            (orderASCFilter ? 1 : -1));

    default:
      return droppedMangas;
  }
});

// Ignored
final ignoredMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id, MangaUserStatusEnum.IGNORED);
});

// OnHold
final orderOnHoldProvider = StateProvider.autoDispose<OnHoldOrderByEnum?>(
  (ref) => OnHoldOrderByEnum.alphabetical,
);
final orderASCOnHoldProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);
final onHoldMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id, MangaUserStatusEnum.ON_HOLD);
});
final filteredOnHoldMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderOnHoldProvider);
  var orderASCFilter = ref.watch(orderASCOnHoldProvider);
  var onHoldMangas =
      ref.watch(onHoldMangasProvider).asData?.value.toList() ?? [];

  switch (orderFilter) {
    case OnHoldOrderByEnum.alphabetical:
      return onHoldMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case OnHoldOrderByEnum.lastRead:
      return onHoldMangas
        ..sort((a, b) =>
            (a.finishedReadingDate == null
                ? 0
                : b.finishedReadingDate == null
                    ? 1
                    : a.finishedReadingDate!
                        .compareTo(b.finishedReadingDate!)) *
            (orderASCFilter ? 1 : -1));
    case OnHoldOrderByEnum.lastUpdated:
      return onHoldMangas
        ..sort((a, b) =>
            (a.manga.lastChapterDate == null
                ? 0
                : b.manga.lastChapterDate == null
                    ? 1
                    : a.manga.lastChapterDate!
                        .compareTo(b.manga.lastChapterDate!)) *
            (orderASCFilter ? 1 : -1));
    default:
      return onHoldMangas;
  }
});

// Planning
final orderPlanningProvider = StateProvider.autoDispose<PlanningOrderByEnum?>(
  (ref) => null,
);
final orderASCPlanningProvider = StateProvider.autoDispose<bool>(
  (ref) => true,
);

final planningMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id, MangaUserStatusEnum.PLANNED);
});

final filteredPlanningMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderPlanningProvider);
  var orderASCFilter = ref.watch(orderASCPlanningProvider);
  var planningMangas =
      ref.watch(planningMangasProvider).asData?.value.toList() ?? [];

  switch (orderFilter) {
    case PlanningOrderByEnum.alphabetical:
      return planningMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case PlanningOrderByEnum.lastAdded:
      return planningMangas
        ..sort((a, b) =>
            (a.addedToStatusDate == null
                ? 0
                : b.addedToStatusDate == null
                    ? 1
                    : a.addedToStatusDate!.compareTo(b.addedToStatusDate!)) *
            (orderASCFilter ? 1 : -1));
    default:
      return planningMangas;
  }
});

// Waiting
final orderWaitingProvider = StateProvider.autoDispose<ReadingOrderByEnum?>(
  (ref) => ReadingOrderByEnum.lastUpdated,
);
final orderASCWaitingProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final waitingMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id, MangaUserStatusEnum.READING);
});

final filteredWaitingMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderReadingProvider);
  var orderASCFilter = ref.watch(orderASCReadingProvider);
  var readingMangas = ref
          .watch(waitingMangasProvider)
          .asData
          ?.value
          .where((element) =>
              element.filteredReadChapters == element.filteredTotalChapters)
          .toList() ??
      [];

  switch (orderFilter) {
    case ReadingOrderByEnum.alphabetical:
      return readingMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case ReadingOrderByEnum.lastRead:
      return readingMangas
        ..sort((a, b) =>
            (a.finishedReadingDate == null
                ? 0
                : b.finishedReadingDate == null
                    ? 1
                    : a.finishedReadingDate!
                        .compareTo(b.finishedReadingDate!)) *
            (orderASCFilter ? 1 : -1));
    case ReadingOrderByEnum.lastUpdated:
      return readingMangas
        ..sort((a, b) =>
            (a.manga.lastChapterDate == null
                ? 0
                : b.manga.lastChapterDate == null
                    ? 1
                    : a.manga.lastChapterDate!
                        .compareTo(b.manga.lastChapterDate!)) *
            (orderASCFilter ? 1 : -1));
    default:
      return readingMangas;
  }
});

// Reading
final orderReadingProvider = StateProvider.autoDispose<ReadingOrderByEnum?>(
  (ref) => ReadingOrderByEnum.lastRead,
);

final orderASCReadingProvider = StateProvider.autoDispose<bool>(
  (ref) => false,
);

final readingViewModeListProvider = StateProvider<bool>(
  (ref) {
    var sharedPrefs = ref.watch(sharedPreferencesProvider);
    return sharedPrefs.getBool(localStorageReadingListView) ?? true;
  },
);

final readingMangasProvider =
    FutureProvider.autoDispose<List<MangaUserData>>((ref) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return mangaUsersRepo.getMangaDataByStatusByUser(
      ref.watch(appStateProvider).loggedUser!.id, MangaUserStatusEnum.READING);
});

final filteredReadingMangasProvider =
    Provider.autoDispose<List<MangaUserData>>((ref) {
  var orderFilter = ref.watch(orderReadingProvider);
  var orderASCFilter = ref.watch(orderASCReadingProvider);
  var readingMangas = ref.watch(readingMangasProvider).asData?.value;
  readingMangas = readingMangas
          ?.where((element) =>
              element.filteredReadChapters < element.filteredTotalChapters)
          .toList() ??
      [];

  switch (orderFilter) {
    case ReadingOrderByEnum.alphabetical:
      return readingMangas
        ..sort((a, b) =>
            a.manga.name.compareTo(b.manga.name) * (orderASCFilter ? 1 : -1));
    case ReadingOrderByEnum.lastRead:
      return readingMangas
        ..sort((a, b) =>
            (a.finishedReadingDate == null
                ? 0
                : b.finishedReadingDate == null
                    ? 1
                    : a.finishedReadingDate!
                        .compareTo(b.finishedReadingDate!)) *
            (orderASCFilter ? 1 : -1));
    case ReadingOrderByEnum.lastUpdated:
      return readingMangas
        ..sort((a, b) =>
            (a.manga.lastChapterDate == null
                ? 0
                : b.manga.lastChapterDate == null
                    ? 1
                    : a.manga.lastChapterDate!
                        .compareTo(b.manga.lastChapterDate!)) *
            (orderASCFilter ? 1 : -1));
    default:
      return readingMangas;
  }
});
