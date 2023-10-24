import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_users_repository.dart';

final mangaRecommendationsProvider = FutureProvider.autoDispose((ref) async {
  var mangaUsersRepo = ref.watch(mangaUsersRepositoryProvider);
  return await mangaUsersRepo.getMangaRecommendations();
});

final communityActivitiesProvider = FutureProvider.autoDispose((ref) async {
  var mangaUsersRepo = ref.watch(mangaUsersRepositoryProvider);
  return await mangaUsersRepo.getCommunityActivity();
});
