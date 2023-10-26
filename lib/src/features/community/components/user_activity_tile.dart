import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/user_activity_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_activity.dart';
import 'package:shounengaming_mangas_mobile/src/features/manga_profile/screens/manga_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/user_profile/screens/user_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/date_helper.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/enums_translation.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

class UserActivityTile extends StatelessWidget {
  final MangaUserActivity activity;
  const UserActivityTile(this.activity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Color.fromARGB(100, 55, 55, 55),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              navigationKey.currentState?.push(
                MaterialPageRoute(
                    builder: (context) =>
                        MangaProfileScreen(activity.manga.id)),
              );
            },
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    bottomLeft: Radius.circular(2)),
                child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    width: 55,
                    imageUrl: activity.manga.imagesUrls[0])),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      navigationKey.currentState?.push(
                        MaterialPageRoute(
                            builder: (context) =>
                                UserProfileScreen(activity.user.id)),
                      );
                    },
                    child: Text(
                      activity.user.fullName,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: palette[2],
                      ),
                    ),
                  ),
                  _getDescriptionWidget(),
                  InkWell(
                    onTap: () {
                      navigationKey.currentState?.push(
                        MaterialPageRoute(
                            builder: (context) =>
                                UserProfileScreen(activity.user.id)),
                      );
                    },
                    child: CircleAvatar(
                      radius: 12,
                      backgroundImage: CachedNetworkImageProvider(
                          activity.user.discordImage!),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
            child: Column(
              children: [
                Tooltip(
                  message: DateFormat("dd/MM/yyyy HH:mm")
                      .format(activity.madeAt.toLocal()),
                  child: Text(
                    howMuchHasPassed(activity.madeAt.toLocal()),
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Spacer()
              ],
            ),
          )
        ],
      ),
    );
  }

  RichText _getDescriptionWidget() {
    switch (activity.activityType) {
      case UserActivityTypeEnum.ADD_MANGA:
        return RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[300],
                ),
                children: [
                  TextSpan(text: "Added "),
                  TextSpan(
                      text: "${activity.manga.name}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600))
                ]));
      case UserActivityTypeEnum.CHANGE_STATUS:
        return RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[300],
                ),
                children: activity.previousState == null
                    ? [
                        TextSpan(text: "Put on "),
                        TextSpan(
                            text: "${translateMangaStatus(activity.newState)}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ]
                    : activity.newState == null
                        ? [
                            TextSpan(text: "Removed from "),
                            TextSpan(
                                text:
                                    "${translateMangaStatus(activity.previousState)}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ]
                        : [
                            TextSpan(text: "Changed from "),
                            TextSpan(
                                text:
                                    "${translateMangaStatus(activity.previousState)}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            TextSpan(text: " to "),
                            TextSpan(
                                text:
                                    "${translateMangaStatus(activity.newState)}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ]));
      case UserActivityTypeEnum.SEE_CHAPTER:
        return RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[300],
                ),
                children: [
                  TextSpan(
                      text:
                          activity.firstChapterRead == activity.lastChapterRead
                              ? "Read chapter "
                              : "Read chapters "),
                  TextSpan(
                      text: activity.firstChapterRead ==
                              activity.lastChapterRead
                          ? "${removeDecimalZeroFormat(activity.firstChapterRead)}"
                          : "${removeDecimalZeroFormat(activity.firstChapterRead)} - ${removeDecimalZeroFormat(activity.lastChapterRead)}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600))
                ]));
      case UserActivityTypeEnum.UNSEE_CHAPTER:
        return RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[300],
                ),
                children: [
                  TextSpan(
                      text:
                          activity.firstChapterRead == activity.lastChapterRead
                              ? "Unread chapter "
                              : "Unread chapters "),
                  TextSpan(
                      text: activity.firstChapterRead ==
                              activity.lastChapterRead
                          ? "${removeDecimalZeroFormat(activity.firstChapterRead)}"
                          : "${removeDecimalZeroFormat(activity.firstChapterRead)} - ${removeDecimalZeroFormat(activity.lastChapterRead)}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600))
                ]));
      default:
        return RichText(text: TextSpan());
    }
  }
}

String removeDecimalZeroFormat(double? n) {
  return n == null ? "" : n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}
