import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/community/providers/search_manga_recommendations_controller.dart';

final mangaRecommendationsProvider = FutureProvider.autoDispose((ref) async {
  var mangaRepo = ref.watch(mangaRepositoryProvider);
  return await mangaRepo.getMangaRecommendations();
});

final communityActivitiesProvider = FutureProvider.autoDispose((ref) async {
  var mangaUsersRepo = ref.watch(mangaUsersRepositoryProvider);
  return await mangaUsersRepo.getCommunityActivity();
});

final searchRecommendationsControllerProvider =
    StateNotifierProvider.autoDispose<SearchMangaRecommendationsController,
            SearchMangaRecommendationsState>(
        (ref) => SearchMangaRecommendationsController(ref));
