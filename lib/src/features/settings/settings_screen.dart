import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    CircleAvatar(),
                    Column(
                      children: [Text('Name'), Text('Description')],
                    )
                  ],
                ),
                const Text('Settings'),
                ListTile(
                  title: const Text('Add New Manga'),
                  onTap: () {},
                )
              ],
            )));
  }
}
