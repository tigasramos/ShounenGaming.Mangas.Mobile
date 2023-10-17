import 'package:shounengaming_mangas_mobile/src/data/models/user.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/user_mangas_configs.dart';

class AppState {
  User? loggedUser;
  UserMangasConfigs? userConfigs;

  bool loadingAuth;

  AppState({
    this.loggedUser,
    this.userConfigs,
    this.loadingAuth = false,
  });

  AppState copyWith({
    User? loggedUser,
    UserMangasConfigs? userConfigs,
    bool? loadingAuth,
  }) {
    return AppState(
      loggedUser: loggedUser ?? this.loggedUser,
      userConfigs: userConfigs ?? this.userConfigs,
      loadingAuth: loadingAuth ?? this.loadingAuth,
    );
  }

  AppState resetUser() {
    return AppState(
      loggedUser: null,
      userConfigs: null,
      loadingAuth: false,
    );
  }
}
