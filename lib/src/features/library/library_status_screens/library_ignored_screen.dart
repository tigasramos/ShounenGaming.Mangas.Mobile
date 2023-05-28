import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LibraryIgnoredScreen extends StatelessWidget {
  const LibraryIgnoredScreen({super.key});

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
        Expanded(
          child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 110,
            crossAxisSpacing: 10,
            shrinkWrap: true,
            childAspectRatio: 0.70,
            mainAxisSpacing: 10,
            children: const [
              LibraryIgnoredMangaTile(),
              LibraryIgnoredMangaTile(),
              LibraryIgnoredMangaTile(),
              LibraryIgnoredMangaTile(),
              LibraryIgnoredMangaTile(),
              LibraryIgnoredMangaTile(),
              LibraryIgnoredMangaTile(),
            ],
          ),
        ),
      ],
    );
  }
}

class LibraryIgnoredMangaTile extends StatelessWidget {
  const LibraryIgnoredMangaTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Expanded(
              child: CachedNetworkImage(
                  imageUrl:
                      'https://cdn.myanimelist.net/images/manga/2/253146.jpg')),
          const Text('One Piece')
        ],
      ),
    );
  }
}
