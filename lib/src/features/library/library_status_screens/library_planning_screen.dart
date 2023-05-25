import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;

class LibraryPlanningScreen extends StatelessWidget {
  const LibraryPlanningScreen({super.key});

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
                LibraryPlanningMangTile(),
                LibraryPlanningMangTile(),
                LibraryPlanningMangTile(),
                LibraryPlanningMangTile(),
                LibraryPlanningMangTile(),
                LibraryPlanningMangTile(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LibraryPlanningMangTile extends StatelessWidget {
  const LibraryPlanningMangTile({super.key});

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
            Badge(
              badgeContent: const Text(
                '200',
                style: TextStyle(fontSize: 9),
              ),
              badgeStyle: BadgeStyle(
                  shape: BadgeShape.square,
                  badgeColor: Theme.of(context).primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  borderRadius: BorderRadius.circular(2)),
              child: CachedNetworkImage(
                imageUrl:
                    'https://cdn.myanimelist.net/images/manga/2/253146.jpg',
                filterQuality: FilterQuality.high,
                fit: BoxFit.fitHeight,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    'One Piece',
                    minFontSize: 16,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w500, height: 1.2),
                  ),
                  Text(
                    'Manga, 1999-?',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                  Text(
                    'Shounen, Adventure',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        'Added at: 21st Feb 2023',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ],
                  ),
                  SizedBox(
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
