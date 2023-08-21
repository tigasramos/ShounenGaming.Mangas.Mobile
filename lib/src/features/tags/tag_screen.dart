import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'tag_manga_card.dart';
import 'tag_provider.dart';

class TagScreen extends ConsumerWidget {
  final String tag;
  const TagScreen(this.tag, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '$tag Mangas (${ref.watch(mangasFromTagProvider(tag)).asData?.value.length ?? "0"})'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: ref.watch(mangasFromTagProvider(tag)).when(
                data: (data) => [
                  const SizedBox(
                    height: 4,
                  ),
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: MediaQuery.of(context).size.width < 550
                        ? 3
                        : MediaQuery.of(context).size.width ~/ 120,
                    shrinkWrap: true,
                    childAspectRatio: 0.70,
                    children: data.map((e) => TagMangaCard(e)).toList(),
                  ),
                ],
                error: (error, stackTrace) => [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(error.toString())
                ],
                loading: () => [const LinearProgressIndicator()],
              ),
        ),
      ),
    );
  }
}
