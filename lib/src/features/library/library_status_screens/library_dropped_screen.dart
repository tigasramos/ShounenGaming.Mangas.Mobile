import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LibraryDroppedScreen extends StatelessWidget {
  const LibraryDroppedScreen({super.key});

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
                LibraryDroppedMangaTile(),
                LibraryDroppedMangaTile(),
                LibraryDroppedMangaTile(),
                LibraryDroppedMangaTile(),
                LibraryDroppedMangaTile(),
                LibraryDroppedMangaTile(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LibraryDroppedMangaTile extends StatelessWidget {
  const LibraryDroppedMangaTile({super.key});

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
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(255, 75, 75, 75),
                        blurRadius: 0,
                        spreadRadius: 0,
                        offset: Offset(3, 4))
                  ]),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://cdn.myanimelist.net/images/manga/5/213340.jpg',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'Blue Lock',
                    minFontSize: 16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(1, 2),
                        blurRadius: 4.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ], fontSize: 21, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  const Text(
                    'Manga, 2017-2022',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Spacer(),
                      Text(
                        '102 / 200',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      minHeight: 9,
                      value: 0.6,
                    ),
                  ),
                  const Spacer(),
                  const Row(
                    children: [
                      Spacer(),
                      Text(
                        'Dropped at: 21st Feb 2023',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
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
