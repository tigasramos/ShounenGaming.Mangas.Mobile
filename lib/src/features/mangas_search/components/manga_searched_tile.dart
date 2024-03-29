import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:dash_flags/dash_flags.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_info.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/enums_translation.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

class MangaSearchedTile extends StatelessWidget {
  final MangaInfo manga;
  const MangaSearchedTile(this.manga, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        navigationKey.currentState?.push(
          MaterialPageRoute(builder: (context) => MangaProfileScreen(manga.id)),
        );
      },
      child: Container(
        height: 100,
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Badge(
                badgeContent: Text(
                  manga.chaptersCount.toString(),
                  style: const TextStyle(fontSize: 10),
                ),
                badgeAnimation: const BadgeAnimation.fade(),
                badgeStyle: BadgeStyle(
                    badgeColor: palette[0],
                    borderRadius: BorderRadius.circular(10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                    shape: BadgeShape.square),
                child: MangaImage(manga.imagesUrls[0], isNSFW: manga.isNSFW)),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: 40),
                    child: AutoSizeText(manga.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        minFontSize: 14,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            height: 1.2)),
                  ),
                  Text(
                    manga.tags.join(", "),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        'Type: ',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontSize: 11),
                      ),
                      CountryFlag(
                        country: getFlag(manga.type),
                        height: 11,
                      )
                    ],
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Status: ',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 11),
                          children: [
                        TextSpan(
                            text: manga.isReleasing ? 'Releasing' : 'Finished',
                            style: const TextStyle(
                                color: Color.fromARGB(220, 255, 255, 255))),
                        TextSpan(
                            text:
                                " (${manga.startedAt?.year} - ${manga.finishedAt?.year ?? "Ongoing"})",
                            style: const TextStyle(
                                color: Color.fromARGB(220, 255, 255, 255))),
                      ])),
                  RichText(
                      text: TextSpan(
                          text: 'Last Update: ',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontSize: 11),
                          children: [
                        TextSpan(
                            text: manga.lastChapterDate != null
                                ? DateFormat("dd MMM yyyy")
                                    .format(manga.lastChapterDate!)
                                : "Not Found",
                            style: const TextStyle(
                                color: Color.fromARGB(220, 255, 255, 255))),
                      ])),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 12,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text("${manga.averageScore?.toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 12,
                        ))
                  ],
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
