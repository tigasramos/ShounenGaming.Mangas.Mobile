import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/others/theme.dart';

import 'featured_mangas_banner.dart';
import 'home_providers.dart';

class FeaturedMangasSection extends ConsumerWidget {
  const FeaturedMangasSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: min(MediaQuery.of(context).size.width / 2, 260),
      child: ref.watch(featuredMangasProvider).when(
            data: (data) => data.isEmpty
                ? Container()
                : CarouselSlider.builder(
                    unlimitedMode: true,
                    enableAutoSlider: true,
                    autoSliderTransitionTime: const Duration(seconds: 1),
                    autoSliderDelay: const Duration(seconds: 4),
                    slideBuilder: (index) {
                      return FeaturedMangasBanner(data[index]);
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
