import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_stats_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/user_repository.dart';

import 'user_profile_state.dart';

class UserProfileController extends StateNotifier<UserProfileState> {
  UserProfileController(this.ref, int userId) : super(UserProfileState()) {
    _fetchUserInfo(userId);
  }

  Ref ref;

  Future _fetchUserInfo(int userId) async {
    state = state.copyWith(isLoading: true);
    var user = await ref.watch(userRepositoryProvider).getUserById(userId);
    var mainStats = await ref
        .watch(mangaUsersStatsRepositoryProvider)
        .getUserMainStats(userId);
    state = state.copyWith(isLoading: false, user: user, mainStats: mainStats);
  }
}
