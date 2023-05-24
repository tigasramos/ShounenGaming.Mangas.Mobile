import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                      isCollapsed: true,
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.zero))),
                ))
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                color: Theme.of(context).primaryColor,
                child: const Text('Search')),
            const SizedBox(
              height: 10,
            ),
            RichText(
                text: const TextSpan(
                    text: 'Found ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                  TextSpan(text: '22', style: TextStyle(color: Colors.white)),
                  TextSpan(text: ' Results')
                ])),
            const SizedBox(
              height: 5,
            ),
            for (int i = 0; i < 10; i++) const MangaSearchedTile()
          ],
        ),
      ),
    );
  }
}

class MangaSearchedTile extends StatelessWidget {
  const MangaSearchedTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Badge(
                badgeContent: const Text(
                  '200',
                  style: TextStyle(fontSize: 10),
                ),
                badgeStyle: BadgeStyle(
                    badgeColor: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    shape: BadgeShape.square),
                child: CachedNetworkImage(
                    imageUrl:
                        'https://cdn.myanimelist.net/images/manga/5/213340.jpg')),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText('Blue Lock',
                    style: TextStyle(shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(1, 2),
                        blurRadius: 4.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ], fontWeight: FontWeight.w500, fontSize: 20, height: 1.2)),
                const Text(
                  'Action, Sports',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(
                    text: const TextSpan(
                        text: 'Status: ',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                        children: [
                      TextSpan(
                          text: 'Releasing',
                          style: TextStyle(color: Colors.white)),
                    ])),
                RichText(
                    text: const TextSpan(
                        text: 'Tyoe: ',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                        children: [
                      TextSpan(
                          text: 'Manga', style: TextStyle(color: Colors.white)),
                    ])),
                RichText(
                    text: const TextSpan(
                        text: 'Last Update: ',
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                        children: [
                      TextSpan(
                          text: ' 22 Feb 2022',
                          style: TextStyle(color: Colors.white)),
                    ])),
              ],
            )
          ],
        ),
      ),
    );
  }
}
