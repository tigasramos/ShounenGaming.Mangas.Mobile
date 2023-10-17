// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import '../providers/manga_search.providers.dart';
import '../components/manga_searched_tile.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var searchState = ref.watch(mangaSearchProvider);
    var functions = ref.read(mangaSearchProvider.notifier);

    return Column(
      children: [
        searchState.isLoadingMangas
            ? const LinearProgressIndicator(
                minHeight: 2,
              )
            : Container(
                height: 2,
              ),
        Expanded(
          child: NotificationListener<ScrollEndNotification>(
            onNotification: (scrollEnd) {
              final metrics = scrollEnd.metrics;
              if (metrics.atEdge) {
                bool isTop = metrics.pixels == 0;
                if (!isTop) {
                  functions.loadNextPage();
                }
              }
              return true;
            },
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextFormField(
                          onEditingComplete: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            await functions.search();
                          },
                          controller: functions.searchController,
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              //isCollapsed: true,
                              contentPadding: const EdgeInsets.all(8),
                              isDense: true,
                              suffixIcon: IconButton(
                                onPressed: functions.searchController.clear,
                                icon: const Icon(Icons.clear),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.zero))),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await functions.search();
                        },
                        minWidth: double.infinity,
                        color: palette[0],
                        child: const Text('Search')),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Found ',
                            style: const TextStyle(color: Colors.grey),
                            children: [
                          TextSpan(
                              text: searchState.totalCount.toString(),
                              style: const TextStyle(color: Colors.white)),
                          const TextSpan(text: ' Results')
                        ])),
                    const SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          MangaSearchedTile(searchState.searchedMangas[index]),
                      itemCount: searchState.searchedMangas.length,
                      shrinkWrap: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
