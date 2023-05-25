import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LibraryCompletedScreen extends StatelessWidget {
  const LibraryCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    onPressed: () {}, icon: const Icon(Icons.filter_alt))),
            const Expanded(flex: 4, child: Center(child: Text('6 Mangas'))),
            Expanded(
                child: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.sort))) //or Tune
          ]),
        ),
        const Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LibraryCompletedMangaTile(),
                LibraryCompletedMangaTile(),
                LibraryCompletedMangaTile(),
                LibraryCompletedMangaTile(),
                LibraryCompletedMangaTile(),
                LibraryCompletedMangaTile(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LibraryCompletedMangaTile extends StatelessWidget {
  const LibraryCompletedMangaTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: 'https://cdn.myanimelist.net/images/manga/2/166254.jpg',
              filterQuality: FilterQuality.high,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeText(
                    'Black Clover',
                    minFontSize: 16,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  const Text(
                    'Manga, 2012-2021',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        color: Colors.blue,
                        child: const Text(
                          'MyAnimeList',
                          style: TextStyle(fontSize: 9),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Completed at: 20th Feb 2022',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}