import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/src/features/community/components/user_activity_tile.dart';

import '../providers/community.providers.dart';

class UsersAtivityList extends StatelessWidget {
  const UsersAtivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Activity',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) => LinearProgressIndicator(
                    value: ref.watch(communityActivitiesProvider).when(
                          skipLoadingOnRefresh: false,
                          data: (data) => 1,
                          error: (error, stackTrace) => 1,
                          loading: () => null,
                        ),
                    minHeight: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Consumer(
            builder: (context, ref, child) =>
                ref.watch(communityActivitiesProvider).when(
                      data: (data) => ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
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
