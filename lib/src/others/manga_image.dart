import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MangaImage extends StatelessWidget {
  final String imageUrl;
  const MangaImage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
          boxShadow: [
            BoxShadow(
                color: Colors.deepPurpleAccent,
                blurRadius: 0,
                spreadRadius: 0,
                offset: Offset(2, 2))
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
