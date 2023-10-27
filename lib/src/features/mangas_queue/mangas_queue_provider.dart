import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/queued_manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/shared/hubs_providers.dart';

final queueMangasProvider =
    StreamProvider.autoDispose<List<QueuedManga>>((ref) async* {
  StreamController stream = StreamController();

  //Get Initial Values
  var initialData = await ref.watch(mangaRepositoryProvider).getQueueStatus();
  stream.add(initialData);

  var mangasHub = ref.watch(mangasHubProvider).value;
  if (mangasHub == null) return;

  mangasHub.on('SendMangasQueue', (arguments) {
    var mangasQueued =
        (arguments![0] as List).map((m) => QueuedManga.fromJson(m)).toList();
    if (stream.hasListener) {
      stream.add(mangasQueued);
    }
  });

  ref.onDispose(() {
    mangasHub.off('SendMangasQueue');
  });

  await for (final value in stream.stream) {
    yield value as List<QueuedManga>;
  }
});
