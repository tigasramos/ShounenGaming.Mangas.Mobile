import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/queued_manga.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/enums_translation.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';

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
