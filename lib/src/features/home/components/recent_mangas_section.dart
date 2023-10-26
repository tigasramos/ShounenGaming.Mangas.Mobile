import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/home/components/recent_manga_card.dart';

import '../providers/home.providers.dart';

class RecentMangasSection extends ConsumerWidget {
  static final _padding = EdgeInsets.symmetric(horizontal: 15);
  const RecentMangasSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: _padding,
            child: Row(
              children: [
                Text(
                  'Recent Mangas',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: LinearProgressIndicator(
                    value: ref.watch(newMangasProvider).when(
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
          ),
          SizedBox(
              height: 160,
              child: ref.watch(newMangasProvider).when(
                  data: (data) => ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 15,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          padding: _padding,
                          itemBuilder: (context, index) =>
                              RecentMangaCard(data[index]),
                        ),
                      ),
                  error: (error, stacktrace) => Container(),
                  loading: () => Container()))
        ],
      ),
    );
  }
}
