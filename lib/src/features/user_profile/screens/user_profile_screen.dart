import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/main_stats/main_user_stats_section.dart';
import '../components/status_distribution_section/status_distribution_section.dart';
import '../components/top_tags_section/top_tags_section.dart';
import '../components/activity_heatmap/user_activity_heatmap.dart';
import '../providers/user_profile.providers.dart';
import '../components/manga_types_section/manga_types_section.dart';

class UserProfileScreen extends ConsumerWidget {
  final int userId;
  const UserProfileScreen(this.userId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userProfile = ref.watch(userProfileProvider(userId));
    if (userProfile.isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [LinearProgressIndicator()],
        ),
      );
    }
    //TODO: Maybe AppSliverBar
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("${userProfile.user!.fullName}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                        sigmaX: 6.0, sigmaY: 6.0, tileMode: TileMode.clamp),
                    child: CachedNetworkImage(
                        imageUrl: userProfile.user!.discordImage,
                        errorWidget: (context, url, error) =>
                            const CircularProgressIndicator(),
                        fit: BoxFit.fitWidth,
                        height: 240,
                        width: double.infinity,
                        alignment: Alignment.center),
                  ),
                ),
                Container(
                  height: 240,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Theme.of(context).scaffoldBackgroundColor,
                    Colors.transparent
                  ], begin: Alignment.bottomCenter, end: Alignment.center)),
                ),
                Container(
                  height: 320,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        minRadius: 56,
                        maxRadius: 56,
                        backgroundImage: CachedNetworkImageProvider(
                          userProfile.user!.discordImage,
                          errorListener: () =>
                              const CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        userProfile.user!.fullName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "@${userProfile.user!.username}",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // ! Body
            Column(
              children: [
                MainUserStatsSection(userProfile.mainStats!),
                //StatusDistributionSection(),
                StatusDistributionSection(
                    userProfile.mainStats!.mangaUserStatusCounters, userId),
                UserActivityHeatmap(userId),
                TopTagsSection(userProfile.mainStats!.mangaTagsCounters),
                MangaTypesSection(userProfile.mainStats!.mangaTypeCounters)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
