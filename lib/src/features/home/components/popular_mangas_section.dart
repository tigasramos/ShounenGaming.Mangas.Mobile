import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import '../providers/home.providers.dart';
import 'popular_mangas_banner.dart';

class PopularMangasSection extends ConsumerWidget {
  const PopularMangasSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: min(MediaQuery.of(context).size.width / 2, 260),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
      child: ref.watch(popularMangasProvider).when(
            data: (data) {
              data.shuffle();
              return data.isEmpty
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CarouselSlider.builder(
                          unlimitedMode: true,
                          enableAutoSlider: true,
                          autoSliderTransitionTime: const Duration(seconds: 1),
                          autoSliderDelay: const Duration(seconds: 4),
                          slideBuilder: (index) {
                            return PopularMangasBanner(data[index]);
                          },
                          slideIndicator: CircularSlideIndicator(
                            padding: const EdgeInsets.only(bottom: 10),
                            indicatorRadius: 5,
                            itemSpacing: 15,
                            currentIndicatorColor:
                                Theme.of(context).primaryColor,
                            indicatorBorderColor: palette[0],
                            indicatorBackgroundColor: Colors.white,
                          ),
                          itemCount: data.length > 5 ? 5 : data.length),
                    );
            },
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
