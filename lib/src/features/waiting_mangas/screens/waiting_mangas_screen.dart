import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';

import '../providers/waiting_mangas.providers.dart';

class WaitingMangasScreen extends ConsumerWidget {
  const WaitingMangasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Waiting for Source'),
        ),
        body: ref.watch(waitingMangasProvider).when(
              data: (data) => ListView.builder(
                itemBuilder: (context, index) => InkWell(
                  onTap: () async {
                    await navigationKey.currentState?.push(
                      MaterialPageRoute(
                          builder: (context) =>
                              MangaProfileScreen(data[index].id)),
                    );
                    ref.invalidate(waitingMangasProvider);
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    height: 100,
                    width: double.infinity,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        MangaImage(data[index].imagesUrls[0]),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText(
                                data[index].name,
                                minFontSize: 16,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    shadows: <Shadow>[
                                      // Shadow(
                                      //   offset: const Offset(1, 2),
                                      //   blurRadius: 4.0,
                                      //   color: Theme.of(context).primaryColor,
                                      // ),
                                    ],
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2),
                              ),
                              Text(
                                '${data[index].type.name}, ${data[index].startedAt?.year ?? "?"}-${data[index].finishedAt?.year ?? "?"}',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        )
                      ],
                    ),
                  ),
                ),
                itemCount: data.length,
              ),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const LinearProgressIndicator(),
            ));
  }
}
