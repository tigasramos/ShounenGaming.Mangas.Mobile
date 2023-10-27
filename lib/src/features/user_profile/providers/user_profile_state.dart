import 'package:shounengaming_mangas_mobile/src/data/models/user.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/user_manga_main_stats.dart';

class UserProfileState {
  User? user;
  UserMangaMainStats? mainStats;
  bool isLoading;
  UserProfileState({
    this.user,
    this.mainStats,
    this.isLoading = true,
  });

  UserProfileState copyWith({
    User? user,
    UserMangaMainStats? mainStats,
    bool? isLoading,
  }) {
    return UserProfileState(
      user: user ?? this.user,
      mainStats: mainStats ?? this.mainStats,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
