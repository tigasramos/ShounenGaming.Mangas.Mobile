// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/user_chapter_read_history.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_stats_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/user_profile/providers/user_profile_controller.dart';
import 'package:shounengaming_mangas_mobile/src/features/user_profile/providers/user_profile_state.dart';

import 'user_manga_status_list_params.dart';

final userProfileProvider = StateNotifierProvider.family
    .autoDispose<UserProfileController, UserProfileState, int>(
        (ref, userId) => UserProfileController(ref, userId));

final userMangaStatusListProvider = FutureProvider.family
    .autoDispose<List<MangaUserData>, UserMangaStatusListParams>(
        (ref, params) async {
  var mangaUsersRepo = ref.read(mangaUsersRepositoryProvider);
  return await mangaUsersRepo.getMangaDataByStatusByUser(
      params.userId, params.status);
});

final userActivityListProvider = FutureProvider.family
    .autoDispose<List<UserChapterReadHistory>, int>((ref, userId) async {
  var mangaStatsRepo = ref.read(mangaUsersStatsRepositoryProvider);
  var data = await mangaStatsRepo.getMangaDataByStatusByUser(userId);

  return data
    ..sort(
      (a, b) => b.readAt.compareTo(a.readAt),
    );
});
