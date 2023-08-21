import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/others/hubs_providers.dart';
import 'package:signalr_netcore/signalr_client.dart';

import 'mangas_queue_provider.dart';
import 'queue_manga_card.dart';

class MangasQueueScreen extends ConsumerWidget {
  const MangasQueueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var mangasHub = ref.watch(mangasHubProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mangas Queue"),
        actions: [
          GestureDetector(
            onTap: () async {
              if (mangasHub.hasValue &&
                  mangasHub.value!.state == HubConnectionState.Disconnected) {
                await ref.watch(mangasHubProvider).asData?.value.start();
              }
            },
            child: Tooltip(
              message: ref.watch(mangasHubProvider).when(
                    data: (data) => data.state == HubConnectionState.Connected
                        ? 'Connected'
                        : 'Disconnected',
                    error: (error, stackTrace) => 'Error: $error $stackTrace',
                    loading: () => 'Validating',
                  ),
              child: Container(
                margin: const EdgeInsets.only(right: 15),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: mangasHub.when(
                          data: (data) =>
                              data.state == HubConnectionState.Connected
                                  ? [
                                      Colors.green,
                                      Colors.greenAccent,
                                    ]
                                  : [
                                      Colors.red,
                                      Colors.redAccent,
                                    ],
                          error: (error, stackTrace) => [
                            Colors.red,
                            Colors.redAccent,
                          ],
                          loading: () => [
                            Colors.orange,
                            Colors.orangeAccent,
                          ],
                        )),
                    shape: BoxShape.circle),
              ),
            ),
          )
        ],
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
            loading: () => const LinearProgressIndicator(),
          ),
    );
  }
}
