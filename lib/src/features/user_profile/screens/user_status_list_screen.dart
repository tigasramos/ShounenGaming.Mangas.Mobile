import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_data.dart';
import 'package:shounengaming_mangas_mobile/src/shared/components/manga_image.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/enums_translation.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import '../providers/user_manga_status_list_params.dart';
import '../providers/user_profile.providers.dart';

class UserStatusListScreen extends StatelessWidget {
  final int userId;
  final MangaUserStatusEnum status;
  UserStatusListScreen(this.userId, this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Consumer(
              builder: (context, ref, child) => Text(
                  "${translateMangaStatus(status)} ${ref.watch(userMangaStatusListProvider(UserMangaStatusListParams(userId: userId, status: status))).when(
                        data: (data) => "(${data.length})",
                        error: (error, stackTrace) => "",
                        loading: () => "",
                      )}")),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            return ref
                .watch(userMangaStatusListProvider(
                    UserMangaStatusListParams(userId: userId, status: status)))
                .when(
              data: (data) {
                data.sort(
                  (a, b) {
                    switch (status) {
                      case MangaUserStatusEnum.ON_HOLD:
                      case MangaUserStatusEnum.READING:
                        if (b.filteredTotalChapters == 0) return -1;
                        if (a.filteredTotalChapters == 0) return 1;
                        return (b.filteredReadChapters /
                                b.filteredTotalChapters)
                            .compareTo(a.filteredReadChapters /
                                a.filteredTotalChapters);
                      case MangaUserStatusEnum.PLANNED:
                        return b.manga.averageScore
                                ?.compareTo(a.manga.averageScore ?? 0) ??
                            -1;
                      case MangaUserStatusEnum.COMPLETED:
                      case MangaUserStatusEnum.DROPPED:
                        return b.rating?.compareTo(a.rating ?? 0) ?? -1;
                      default:
                        return 0;
                    }
                  },
                );
                return ListView.builder(
                  itemBuilder: (context, index) => UserMangaStatusListCard(
                    data[index],
                    colored: index % 2 == 0,
                  ),
                  itemCount: data.length,
                );
              },
              error: (error, stackTrace) {
                return Column(
                  children: [Text(error.toString())],
                );
              },
              loading: () {
                return Column(
                  children: [LinearProgressIndicator()],
                );
              },
            );
          },
        ));
  }
}

class UserMangaStatusListCard extends StatelessWidget {
  final MangaUserData userData;
  final bool colored;
  const UserMangaStatusListCard(this.userData,
      {super.key, this.colored = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: colored ? Colors.black38 : null,
        ),
        //margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          children: [
            Container(
              height: 35,
              width: 35,
              child: MangaImage(userData.manga.imagesUrls[0]),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              flex: 5,
              child: Text(
                userData.manga.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            if (userData.status == MangaUserStatusEnum.READING ||
                userData.status == MangaUserStatusEnum.ON_HOLD)
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        '${userData.filteredReadChapters}/${userData.filteredTotalChapters}'),
                    SizedBox(
                      height: 5,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: userData.filteredTotalChapters == 0
                            ? 0
                            : userData.filteredReadChapters /
                                userData.filteredTotalChapters,
                        color: palette[1],
                      ),
                    )
                  ],
                ),
              ),
            if (userData.status == MangaUserStatusEnum.COMPLETED ||
                userData.status == MangaUserStatusEnum.DROPPED)
              RatingBar.builder(
                initialRating: userData.rating ?? 0,
                minRating: 0,
                itemSize: 12,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            if (userData.status == MangaUserStatusEnum.PLANNED) ...[
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 14,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                "${userData.manga.averageScore?.toStringAsFixed(1)}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ]
          ],
        ));
  }
}
