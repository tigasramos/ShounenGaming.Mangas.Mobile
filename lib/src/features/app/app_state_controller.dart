import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/user_mangas_configs.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/user_repository.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/auth_helper.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';

import 'app_state.dart';

class AppStateController extends StateNotifier<AppState> {
  AppStateController(this.ref) : super(AppState()) {
    getAuthState();
  }

  Ref ref;

  Future getAuthState() async {
    state = state.copyWith(loadingAuth: true);
    await updateStoreAndState(ref);
    state = state.copyWith(loadingAuth: false);
  }

  Future updateUser() async {
    try {
      var usersRepo = ref.read(userRepositoryProvider);
      var user = await usersRepo.getLoggedUser();
      var userConfigs = await usersRepo.getUserConfigsForMangas();
      state = state.copyWith(loggedUser: user, userConfigs: userConfigs);
    } catch (e) {
      print(e.toString());
    }
  }

  void setNewConfigs(UserMangasConfigs configs) {
    state = state.copyWith(userConfigs: configs);
  }

  Future logout() async {
    var sharedPreferences = ref.watch(sharedPreferencesProvider);
    await sharedPreferences.remove(localStorageAccessTokenKey);
    await sharedPreferences.remove(localStorageRefreshTokenKey);

    navigationKey.currentState?.popUntil((route) => route.isFirst);
    state = state.resetUser();
  }
}
