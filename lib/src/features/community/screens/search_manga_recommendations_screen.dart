import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_metadata_source_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_metadata.dart';
import 'package:shounengaming_mangas_mobile/src/features/community/providers/community.providers.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_metadata_source_icon.dart';

class SearchMangaRecommendationsScreen extends StatelessWidget {
  const SearchMangaRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Consumer(
              builder: (context, ref, child) => Text(
                  "Recommendations (${ref.watch(searchRecommendationsControllerProvider.select((value) => value.searchedMangas)).length})")),
        ),
        body: SingleChildScrollView(
            child: Consumer(
          builder: (context, ref, child) => ref
                  .watch(searchRecommendationsControllerProvider)
                  .isLoadingSearchedMangas
              ? Column(
                  children: [LinearProgressIndicator()],
                )
              : GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 9 / 16,
                  padding: EdgeInsets.all(12),
                  children: ref
                      .watch(searchRecommendationsControllerProvider
                          .select((value) => value.searchedMangas))
                      .map((e) => SearchedMangaRecommendationCard(e))
                      .toList(),
                ),
        )));
  }
}

class SearchedMangaRecommendationCard extends StatelessWidget {
  final MangaMetadata manga;
  const SearchedMangaRecommendationCard(this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
                    child: Container(
                  margin: const EdgeInsets.only(
                      top: 26, left: 26, right: 26, bottom: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 126,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: manga.imageUrl,
                              width: 90,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(maxHeight: 50),
                                    child: AutoSizeText(
                                      manga.titles.first,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 13,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    manga.tags.join(", "),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      Text("Score: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          )),
                                      Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 10,
                                      ),
                                      Text("${manga.score}",
                                          style: TextStyle(
                                            fontSize: 10,
                                          ))
                                    ],
                                  ),
                                  RichText(
                                      maxLines: 2,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: "Status: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                          TextSpan(
                                            text:
                                                "${manga.status} (${manga.startedAt!.year} - ${manga.finishedAt != null ? "${manga.finishedAt!.year}" : "?"})",
                                          )
                                        ],
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      )),
                                  RichText(
                                      text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "Type: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      TextSpan(text: "${manga.type.name}")
                                    ],
                                    style: TextStyle(
                                      fontSize: 10,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        constraints:
                            BoxConstraints(maxHeight: 130, minHeight: 30),
                        child: SingleChildScrollView(
                          child: Text(
                            manga.description,
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          MangaMetadataSourceIcon(manga.id, manga.source),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Close'),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Consumer(
                            builder: (context, ref, child) {
                              var state = ref.watch(
                                  searchRecommendationsControllerProvider);
                              var existsAlready = state.addedMangas.any((m) =>
                                  manga.source ==
                                          MangaMetadataSourceEnum.MYANIMELIST
                                      ? m.mangaMyAnimeListID == manga.id
                                      : m.mangaAniListID == manga.id);
                              var isLoading = state.isLoadingAddManga;
                              return FilledButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(horizontal: 14))),
                                onPressed: existsAlready || isLoading
                                    ? null
                                    : () async {
                                        await ref
                                            .read(
                                                searchRecommendationsControllerProvider
                                                    .notifier)
                                            .addManga(manga.id, manga.source);
                                      },
                                child: isLoading
                                    ? Container(
                                        child: CircularProgressIndicator(),
                                        height: 15,
                                        width: 15,
                                      )
                                    : Text(existsAlready ? 'Added' : 'Add'),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )));
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    MangaImage(manga.imageUrl),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Consumer(
                          builder: (context, ref, child) => ref
                                  .watch(searchRecommendationsControllerProvider
                                      .select((value) => value.addedMangas))
                                  .any((m) => manga.source ==
                                          MangaMetadataSourceEnum.MYANIMELIST
                                      ? manga.id == m.mangaMyAnimeListID
                                      : manga.id == m.mangaAniListID)
                              ? Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: const Color.fromARGB(180, 0, 0, 0),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                )
                              : Container()),
                    ),
                  ],
                )),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          manga.titles.first,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 10,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "${manga.score?.toStringAsFixed(1)}",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Text(
                    manga.tags.join(", "),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 9, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
