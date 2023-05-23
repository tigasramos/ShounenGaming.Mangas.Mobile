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
            Row(
              children: [
                const Text('Name'),
                const SizedBox(
                  width: 10,
                ),
                Expanded(child: TextFormField())
              ],
            ),
            MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                color: Theme.of(context).primaryColor,
                child: const Text('Search')),
            RichText(
                text: const TextSpan(
                    text: 'Found ',
                    style: TextStyle(color: Colors.grey),
                    children: [
                  TextSpan(text: '22', style: TextStyle(color: Colors.white)),
                  TextSpan(text: ' Results')
                ])),
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
                Text(
                  'Blue Lock',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Text(
                  'Action, Sports',
                  style: TextStyle(color: Colors.grey),
                ),
                RichText(
                    text: const TextSpan(
                        text: 'Status: ',
                        style: TextStyle(color: Colors.grey),
                        children: [
                      TextSpan(
                          text: 'Releasing',
                          style: TextStyle(color: Colors.white)),
                    ])),
                RichText(
                    text: const TextSpan(
                        text: 'Last Update: ',
                        style: TextStyle(color: Colors.grey),
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
