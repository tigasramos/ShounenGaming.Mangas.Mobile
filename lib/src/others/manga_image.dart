import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MangaImage extends StatelessWidget {
  final String imageUrl;
  const MangaImage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 66,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fitWidth,
          errorWidget: (context, url, error) =>
              const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
