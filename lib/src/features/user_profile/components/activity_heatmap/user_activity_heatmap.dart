import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/features/user_profile/screens/user_activity_list_screen.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

import '../../providers/user_profile.providers.dart';

class UserActivityHeatmap extends StatelessWidget {
  final int userId;
  const UserActivityHeatmap(this.userId, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigationKey.currentState?.push(MaterialPageRoute(
          builder: (context) => UserActivityListScreen(userId),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Activity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                //color: Color.fromARGB(255, 42, 39, 48),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ActivityHeatmapWeekDay("Monday", DateTime.monday, userId),
                    ActivityHeatmapWeekDay("Tuesday", DateTime.tuesday, userId),
                    ActivityHeatmapWeekDay(
                        "Wednesday", DateTime.wednesday, userId),
                    ActivityHeatmapWeekDay(
                        "Thursday", DateTime.thursday, userId),
                    ActivityHeatmapWeekDay("Friday", DateTime.friday, userId),
                    ActivityHeatmapWeekDay(
                        "Saturday", DateTime.saturday, userId),
                    ActivityHeatmapWeekDay("Sunday", DateTime.sunday, userId),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityHeatmapWeekDay extends StatelessWidget {
  final int userId;
  final String day;
  final int weekDay;
  const ActivityHeatmapWeekDay(this.day, this.weekDay, this.userId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final numOfWeekDays = (MediaQuery.sizeOf(context).width - 122) ~/ 25 -
        (DateTime.now().weekday > (weekDay - 1) ? 0 : 1);

    DateTime? lastWeekDay;

    DateTime currentDate = DateTime.now();
    while (lastWeekDay == null) {
      if (currentDate.weekday == weekDay) {
        lastWeekDay = currentDate;
      } else
        currentDate = currentDate.add(Duration(days: -1));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 80,
              child: Text(
                day,
                textAlign: TextAlign.end,
              )),
          SizedBox(
            width: 5,
          ),
          for (int i = numOfWeekDays - 1; i >= 0; i--)
            ActivityHeatmapDay(lastWeekDay.add(Duration(days: -7 * i)), userId)
        ],
      ),
    );
  }
}

class ActivityHeatmapDay extends ConsumerWidget {
  final int userId;
  final DateTime date;
  const ActivityHeatmapDay(this.date, this.userId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var num = 0;
    final dailyCounters =
        ref.watch(userProfileProvider(userId)).mainStats?.dailyActivityCounters;
    if (dailyCounters != null) {
      var dateOnly = DateTime(date.year, date.month, date.day);
      if (dailyCounters.containsKey(dateOnly)) {
        num = dailyCounters[dateOnly]!;
      }
    }

    var color = palette[0];
    if (num == 0)
      color = Color.fromARGB(200, 255, 255, 255);
    else if (num < 5)
      color = palette[4];
    else if (num < 10)
      color = palette[3];
    else if (num < 30)
      color = palette[2];
    else if (num < 50) color = palette[1];

    return Tooltip(
      message: "${DateFormat("dd/MM/yyyy").format(date.toLocal())}",
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        height: 15,
        width: 15,
      ),
    );
  }
}
