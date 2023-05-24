import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LatestReleasesSection extends StatelessWidget {
  const LatestReleasesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Latest Releases',
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
          const SizedBox(
            height: 10,
          ),
          const Column(
            children: [
              ChapterReleaseCard(),
              SizedBox(
                height: 10,
              ),
              ChapterReleaseCard(),
              SizedBox(
                height: 10,
              ),
              ChapterReleaseCard(),
              SizedBox(
                height: 10,
              ),
              ChapterReleaseCard(),
              SizedBox(
                height: 10,
              ),
              ChapterReleaseCard(),
            ],
          )
        ]));
  }
}

class ChapterReleaseCard extends StatelessWidget {
  const ChapterReleaseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        children: [
          AspectRatio(
              aspectRatio: 0.66,
              child: CachedNetworkImage(
                fit: BoxFit.fitHeight,
                filterQuality: FilterQuality.high,
                imageUrl:
                    'https://cdn.myanimelist.net/images/manga/2/253146.jpg',
              )),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'One Piece',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  '#1060',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  '#1059',
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
