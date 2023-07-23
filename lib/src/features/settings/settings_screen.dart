import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/roles_enum.dart';
import 'package:shounengaming_mangas_mobile/src/features/settings/add_manga_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/settings/mangas_queue_screen.dart';
import 'package:shounengaming_mangas_mobile/src/features/settings/waiting_mangas_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appState = ref.watch(appStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: appState
                                          .loggedUser?.discordImage !=
                                      null
                                  ? CachedNetworkImageProvider(
                                      appState.loggedUser?.discordImage ?? "")
                                  : null,
                              radius: 23,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appState.loggedUser?.fullName ?? ""),
                                Text(
                                  appState.loggedUser?.username ?? "",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Options',
                        style: TextStyle(fontSize: 19),
                      ),
                      ListTile(
                        leading: const Icon(Icons.post_add),
                        title: const Text('Add New Manga'),
                        onTap: () {
                          navigationKey.currentState?.push(MaterialPageRoute(
                            builder: (context) => const AddMangaScreen(),
                          ));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.post_add),
                        title: const Text('Mangas Queue'),
                        onTap: () {
                          navigationKey.currentState?.push(MaterialPageRoute(
                            builder: (context) => const MangasQueueScreen(),
                          ));
                        },
                      ),
                      if (appState.loggedUser?.role != RolesEnum.USER)
                        ListTile(
                          leading: const Icon(Icons.list_alt),
                          title: const Text('Requested Mangas'),
                          onTap: () {
                            navigationKey.currentState?.push(MaterialPageRoute(
                              builder: (context) => const WaitingMangasScreen(),
                            ));
                          },
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        ref.read(appStateProvider.notifier).logout();
                      },
                      child: const Text('Sign Out')),
                ],
              ))),
    );
  }
}
