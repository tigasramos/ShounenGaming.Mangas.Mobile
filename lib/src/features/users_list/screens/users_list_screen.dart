import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/user_profile/screens/user_profile_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/users_list/providers/users_list.providers.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';

class UsersListScreen extends ConsumerWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Users (${ref.watch(usersListProvider).value?.length ?? 0})'),
        ),
        body: ref.watch(usersListProvider).when(
              data: (data) => ListView(
                children: data
                    .map((user) => InkWell(
                          onTap: () {
                            navigationKey.currentState?.push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserProfileScreen(user.id)),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 13,
                                  backgroundImage: CachedNetworkImageProvider(
                                      user.discordImage!),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("${user.fullName} "),
                                Spacer(),
                                Text(
                                  "@${user.username}",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              error: (error, stackTrace) => Text(error.toString()),
              loading: () => const LinearProgressIndicator(),
            ));
  }
}
