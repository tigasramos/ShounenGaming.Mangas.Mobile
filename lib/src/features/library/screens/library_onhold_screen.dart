import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/library.providers.dart';
import '../providers/library_filters.dart';
import 'library_reading_screen.dart';

class LibraryOnHoldScreen extends ConsumerWidget {
  const LibraryOnHoldScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: ref.watch(onHoldMangasProvider).isLoading
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
                          onPressed: () {},
                          icon: const Icon(Icons.filter_alt))),
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            ref
                                .watch(filteredOnHoldMangasProvider)
                                .length
                                .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(' Mangas')
                        ],
                      ))),
                  Expanded(
                    child: PopupMenuButton(
                      tooltip: 'Order By',
                      initialValue: ref.watch(orderOnHoldProvider),
                      onSelected: (selected) {
                        if (ref.read(orderOnHoldProvider) == selected) {
                          //If selects the same and is Desc, clears order by
                          if (!ref.watch(orderASCOnHoldProvider)) {
                            ref.watch(orderOnHoldProvider.notifier).state =
                                null;
                            ref.watch(orderASCOnHoldProvider.notifier).state =
                                true;
                          }
                          // If select the same and its asc, goes desc
                          else {
                            ref.watch(orderASCOnHoldProvider.notifier).state =
                                !ref.watch(orderASCOnHoldProvider);
                          }
                        }
                        // If not the same changes and goes asc
                        else {
                          ref.watch(orderOnHoldProvider.notifier).state =
                              selected;
                          ref.watch(orderASCOnHoldProvider.notifier).state =
                              true;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: OnHoldOrderByEnum.alphabetical,
                          child: Row(
                            children: [
                              const Text('Alphabetical'),
                              const Spacer(),
                              if (ref.watch(orderOnHoldProvider) ==
                                  OnHoldOrderByEnum.alphabetical)
                                Icon(ref.watch(orderASCOnHoldProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: OnHoldOrderByEnum.lastRead,
                          child: Row(
                            children: [
                              const Text('Last Read'),
                              const Spacer(),
                              if (ref.watch(orderOnHoldProvider) ==
                                  OnHoldOrderByEnum.lastRead)
                                Icon(ref.watch(orderASCOnHoldProvider)
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward)
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: OnHoldOrderByEnum.lastUpdated,
                          child: Row(
                            children: [
                              const Text('Last Updated'),
                              const Spacer(),
                              if (ref.watch(orderOnHoldProvider) ==
                                  OnHoldOrderByEnum.lastUpdated)
                                Icon(ref.watch(orderASCOnHoldProvider)
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
                          i < ref.watch(filteredOnHoldMangasProvider).length;
                          i++)
                        LibraryReadingMangaTile(i, filteredOnHoldMangasProvider)
                    ],
                  ),
                ),
              ),
            ],
    );
  }
}
