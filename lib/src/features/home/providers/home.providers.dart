import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';

final newMangasProvider = FutureProvider.autoDispose((ref) async {
  var mangasRepo = ref.watch(mangaRepositoryProvider);
  return await mangasRepo.getRecentlyAddedMangas();
});

final popularMangasProvider = FutureProvider.autoDispose((ref) async {
  var mangasRepo = ref.watch(mangaRepositoryProvider);
  return await mangasRepo.getPopularMangas();
});

final newChaptersProvider = FutureProvider.autoDispose((ref) async {
  var mangasRepo = ref.watch(mangaRepositoryProvider);
  return await mangasRepo.getRecentlyReleasedChapters();
});
