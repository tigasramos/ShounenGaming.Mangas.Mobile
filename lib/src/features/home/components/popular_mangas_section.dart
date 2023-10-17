import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/home.providers.dart';
import 'popular_manga_card.dart';

class PopularMangasSection extends ConsumerWidget {
  const PopularMangasSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Popular Mangas',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: ref.watch(popularMangasProvider).when(
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
          SizedBox(
              height: 140,
              child: ref.watch(popularMangasProvider).when(
                  data: (data) => ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 15,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) =>
                            PopularMangaCard(index + 1, data[index]),
                      ),
                  error: (error, stacktrace) => Container(),
                  loading: () => Container()))
        ],
      ),
    );
  }
}
