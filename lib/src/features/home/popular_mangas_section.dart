import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PopularMangasSection extends StatelessWidget {
  const PopularMangasSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                  value: 1,
                  minHeight: 1,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          ),
          SizedBox(
            height: 135,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                width: 15,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) => const PopularMangaCard(),
            ),
          )
        ],
      ),
    );
  }
}

class PopularMangaCard extends StatelessWidget {
  const PopularMangaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 5,
        ),
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              Expanded(
                child: AspectRatio(
                    aspectRatio: 0.66,
                    child: CachedNetworkImage(
                      fit: BoxFit.fitWidth,
                      filterQuality: FilterQuality.high,
                      imageUrl:
                          'https://cdn.myanimelist.net/images/manga/5/213340.jpg',
                    )),
              ),
              SizedBox(
                height: 16,
                child: AutoSizeText(
                  generateRandomString(Random().nextInt(30) + 1),
                  maxLines: 1,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

String generateRandomString(int lengthOfString) {
  final random = Random();
  const allChars =
      'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
  // below statement will generate a random string of length using the characters
  // and length provided to it
  final randomString = List.generate(
          lengthOfString, (index) => allChars[random.nextInt(allChars.length)])
      .join();
  return randomString; // return the generated string
}
