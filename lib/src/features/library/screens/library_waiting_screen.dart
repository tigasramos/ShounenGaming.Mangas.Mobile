import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/library.providers.dart';
import '../providers/library_filters.dart';
import 'library_reading_screen.dart';

class LibraryWaitingScreen extends ConsumerWidget {
  const LibraryWaitingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: ref.watch(waitingMangasProvider).isLoading
          ? [
              const LinearProgressIndicator(
                minHeight: 2,
              )
            ]
          : [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                height: 50,
                color: Theme.of(context)
                    .scaffoldBackgroundColor
                    .withBlue(35)
                    .withRed(30),
                child: Row(children: [
                  Expanded(
                      child: IconButton(
                          onPressed: () {
                            // showModalBottomSheet<void>(
                            //   context: context,
                            //   builder: (BuildContext context) {
                            //     return SizedBox(
                            //       height: 300,
                            //       child: Center(
                            //         child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: <Widget>[
                            //             const Text('Modal BottomSheet'),
                            //             ElevatedButton(
                            //               child: const Text('Close BottomSheet'),
                            //               onPressed: () => Navigator.pop(context),
                            //             ),
                            //             const Text('Show Only with New Chapters'),
                            //             const Text('Manga Type'),
                            //             const Text('Show Only with New Chapters'),
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            // );
                          },
                          icon: const Icon(Icons.filter_alt))),
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: Text(
                              '${ref.watch(filteredWaitingMangasProvider).length.toString()} Mangas'))),
                  Expanded(
                    child: PopupMenuButton(
                      tooltip: 'Order By',
                      initialValue: ref.watch(orderWaitingProvider),
                      onSelected: (selected) {
                        if (ref.read(orderWaitingProvider) == selected) {
                          ref.watch(orderASCWaitingProvider.notifier).state =
                              !ref.watch(orderASCWaitingProvider);
                        } else {
                          ref.watch(orderWaitingProvider.notifier).state =
                              selected;
                          ref.watch(orderASCWaitingProvider.notifier).state =
                              true;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: ReadingOrderByEnum.alphabetical,
                          child: Row(
                            children: [
                              const Text('Alphabetical'),
                              const Spacer(),
                              if (ref.watch(orderWaitingProvider) ==
                                  ReadingOrderByEnum.alphabetical)
                                Icon(ref.watch(orderASCWaitingProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: ReadingOrderByEnum.lastRead,
                          child: Row(
                            children: [
                              const Text('Last Read'),
                              const Spacer(),
                              if (ref.watch(orderWaitingProvider) ==
                                  ReadingOrderByEnum.lastRead)
                                Icon(ref.watch(orderASCWaitingProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: ReadingOrderByEnum.lastUpdated,
                          child: Row(
                            children: [
                              const Text('Last Updated'),
                              const Spacer(),
                              if (ref.watch(orderWaitingProvider) ==
                                  ReadingOrderByEnum.lastUpdated)
                                Icon(ref.watch(orderASCWaitingProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                      ],
                      child: const Icon(Icons.sort),
                    ),
                  ), //or Tune
                ]),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 0;
                          i < ref.watch(filteredWaitingMangasProvider).length;
                          i++)
                        LibraryReadingMangaTile(
                            i, filteredWaitingMangasProvider)
                    ],
                  ),
                ),
              ),
            ],
    );
  }
}
