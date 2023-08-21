import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/nsfw_behaviour_enum.dart';
import 'package:shounengaming_mangas_mobile/src/features/app/app_state_provider.dart';

class MangaImage extends ConsumerWidget {
  final String imageUrl;
  final bool isNSFW;
  const MangaImage(this.imageUrl, {super.key, this.isNSFW = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var blurImage = isNSFW &&
        ref.watch(appStateProvider).userConfigs?.nsfwBehaviour ==
            NSFWBehaviourEnum.BLUR_IMAGES;

    return AspectRatio(
      aspectRatio: 0.66,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
            border: Border.all(color: Colors.white30),
            boxShadow: const [
              // BoxShadow(
              //     color: Color.fromARGB(255, 58, 58, 58),
              //     blurRadius: 0,
              //     spreadRadius: 0,
              //     offset: Offset(2, 2))
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
          child: blurImage
              ? ImageFiltered(
                  imageFilter: ImageFilter.blur(
                      sigmaX: 8, sigmaY: 8, tileMode: TileMode.clamp),
                  child: _buildImage(),
                )
              : _buildImage(),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      //width: 66,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => const CircularProgressIndicator(),
    );
  }
}
