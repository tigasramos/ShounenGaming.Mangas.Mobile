/*
https://pub.dev/packages/carousel_slider
https://pub.dev/packages/flutter_carousel_slider
https://pub.dev/packages/banner_carousel
*/
import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/data/repositories/manga_repository.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

final featuredMangasProvider = FutureProvider.autoDispose((ref) async {
  var mangasRepo = ref.watch(mangaRepositoryProvider);
  return await mangasRepo.getFeaturedMangas();
});

class FeaturedMangasSection extends ConsumerWidget {
  const FeaturedMangasSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: min(MediaQuery.of(context).size.width / 2, 260),
      child: ref.watch(featuredMangasProvider).when(
            data: (data) => CarouselSlider.builder(
                unlimitedMode: true,
                enableAutoSlider: true,
                autoSliderTransitionTime: const Duration(seconds: 1),
                autoSliderDelay: const Duration(seconds: 4),
                slideBuilder: (index) {
                  return FeaturedMangaBanner(data[index]);
                },
                slideTransform: const CubeTransform(),
                slideIndicator: CircularSlideIndicator(
                  padding: const EdgeInsets.only(bottom: 10),
                  indicatorRadius: 5,
                  itemSpacing: 15,
                  currentIndicatorColor: Theme.of(context).primaryColor,
                  indicatorBorderColor: palette[0],
                  indicatorBackgroundColor: Colors.white,
                ),
                itemCount: data.length),
            error: (error, stackTrace) => Container(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}

class FeaturedMangaBanner extends StatelessWidget {
  final MangaInfo manga;
  const FeaturedMangaBanner(this.manga, {super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: width,
      child: Stack(
        children: [
          SizedBox(
            width: width,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                  sigmaY: 3, sigmaX: 3, tileMode: TileMode.mirror),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    const CircularProgressIndicator(),
                imageUrl: manga.imagesUrls[0],
                fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.high,
                alignment: const Alignment(0, -0.5),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: min(width / 20, 50),
                bottom: min(width / 12, 50),
                left: width / 15,
                right: width / 15),
            child: Container(
              color: Colors.white60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        manga.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        manga.tags.take(3).join(", "),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: palette[0]),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      MaterialButton(
                        onPressed: () {
                          navigationKey.currentState?.push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    MangaProfileScreen(manga.id)),
                          );
                        },
                        minWidth: 80,
                        height: 34,
                        elevation: 5,
                        color: palette[0],
                        child: const Text(
                          'Read Now',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      // FilledButton(
                      //   onPressed: () {},
                      //   style: FilledButton.styleFrom(
                      //       backgroundColor: Theme.of(context).primaryColor,
                      //       shape: const LinearBorder(),
                      //       minimumSize: const Size(80, 30),
                      //       elevation: 3),
                      //   child: const Text(
                      //     'Read Now',
                      //     style: TextStyle(color: Colors.white, fontSize: 12),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
