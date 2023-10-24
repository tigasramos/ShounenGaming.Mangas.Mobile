import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/community/components/user_activity_tile.dart';

import '../providers/community.providers.dart';

class UsersAtivityList extends StatelessWidget {
  const UsersAtivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Activity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Consumer(
            builder: (context, ref, child) =>
                ref.watch(communityActivitiesProvider).when(
                      data: (data) => ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) =>
                              UserActivityTile(data[index])),
                      error: (error, stackTrace) => Container(),
                      loading: () => Container(),
                    ),
          )
        ],
      ),
    );
  }
}
