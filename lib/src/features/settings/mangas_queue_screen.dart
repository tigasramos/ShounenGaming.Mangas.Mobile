import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/queued_manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/others/enums_translation.dart';
import 'package:shounengaming_mangas_mobile/src/others/hubs_providers.dart';
import 'package:shounengaming_mangas_mobile/src/others/manga_image.dart';

class MangasQueueScreen extends ConsumerWidget {
  const MangasQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mangas Queue"),
      ),
      body: ref.watch(queueMangasProvider).when(
            data: (data) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.isEmpty
                        ? [
                            const Center(
                                child: Text("There's no Mangas in Queue"))
                          ]
                        : [
                            const Text(
                              'Current Manga',
                              style: TextStyle(fontSize: 16),
                            ),
                            QueuedMangaCard(data.take(1).first),
                            const SizedBox(height: 5),
                            Text(
                              'Next (${data.skip(1).length})',
                              style: const TextStyle(fontSize: 16),
                            ),
                            ...data
                                .skip(1)
                                .map((e) => QueuedMangaCard(e))
                                .toList()
                          ],
                  ),
                ),
              );
            },
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => const CircularProgressIndicator(),
          ),
    );
  }
}

class QueuedMangaCard extends StatelessWidget {
  final QueuedManga queuedManga;
  const QueuedMangaCard(this.queuedManga, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 4),
      height: queuedManga.progress != null ? 110 : 60,
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          MangaImage(queuedManga.manga.imagesUrls[0]),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  queuedManga.manga.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
                ),
                if (queuedManga.progress != null) ...[
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          "${translateMangaSource(queuedManga.progress!.currentSource)} (${queuedManga.progress!.currentChapter} / ${queuedManga.progress!.totalChapters})",
                          style: const TextStyle(fontSize: 12),
                          minFontSize: 8,
                          maxLines: 2,
                        ),
                      ),
                      if (MediaQuery.of(context).size.width > 300)
                        Text(
                          "${queuedManga.progress!.percentage.toStringAsFixed(1)}%",
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  LinearProgressIndicator(
                    value: queuedManga.progress!.percentage / 100,
                    minHeight: 5,
                  )
                ],
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'By: ${queuedManga.queuedByUser != null ? queuedManga.queuedByUser!.fullName : "System"}',
                        style: const TextStyle(fontSize: 12),
                        maxLines: 2,
                      ),
                    ),
                    if (MediaQuery.of(context).size.width > 300)
                      Text(
                        DateFormat("dd/MMM HH:mm")
                            .format(queuedManga.queuedAt.toLocal()),
                        style: const TextStyle(fontSize: 12),
                      )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
        (arguments![0] as List).map((m) => QueuedManga.fromMap(m)).toList();
    if (stream.hasListener) {
      stream.add(mangasQueued);
    }
  });

  await for (final value in stream.stream) {
    yield value as List<QueuedManga>;
  }
});
