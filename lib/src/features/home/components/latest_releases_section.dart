import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/home.providers.dart';
import 'manga_release_card.dart';

class LatestReleasesSection extends ConsumerWidget {
  const LatestReleasesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Latest Releases',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: ref.watch(newChaptersProvider).when(
                        skipLoadingOnRefresh: false,
                        data: (data) => 1,
                        error: (error, stackTrace) => 1,
                        loading: () => null,
                      ),
                  minHeight: 1,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: ref.watch(newChaptersProvider).when(
                data: (data) => data.map((e) => MangaReleaseCard(e)).toList(),
                error: (error, stacktrace) => [Container()],
                loading: () => []),
          )
        ]));
  }
}
