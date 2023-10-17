import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';

final mangasFromTagProvider =
    FutureProvider.family.autoDispose((ref, String tag) async {
  var mangasRepo = ref.watch(mangaRepositoryProvider);

  var mangas = await mangasRepo.getMangasFromTag(tag);
  mangas.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  return mangas;
});
