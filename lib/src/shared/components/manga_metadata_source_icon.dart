import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_metadata_source_enum.dart';

class MangaMetadataSourceIcon extends StatelessWidget {
  final int id;
  final MangaMetadataSourceEnum source;
  final double size;
  const MangaMetadataSourceIcon(this.id, this.source,
      {super.key, this.size = 25});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await launch(
            source == MangaMetadataSourceEnum.MYANIMELIST
                ? 'https://myanimelist.net/manga/$id'
                : 'https://anilist.co/manga/$id',
            customTabsOption: CustomTabsOption(
              toolbarColor: Theme.of(context).primaryColor,
              enableDefaultShare: true,
              enableUrlBarHiding: true,
              showPageTitle: true,
            ),
            safariVCOption: SafariViewControllerOption(
              preferredBarTintColor: Theme.of(context).primaryColor,
              preferredControlTintColor: Colors.white,
              barCollapsingEnabled: true,
              entersReaderIfAvailable: false,
              dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
            ),
          );
        } catch (e, stackTrace) {
          await Sentry.captureException(e, stackTrace: stackTrace);
          debugPrint(e.toString());
        }
      },
      child: Image.asset(
        source == MangaMetadataSourceEnum.MYANIMELIST
            ? "assets/images/sources/mal_icon.png"
            : "assets/images/sources/al_icon.png",
        height: size,
      ),
    );
  }
}
