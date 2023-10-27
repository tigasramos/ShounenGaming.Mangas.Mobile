import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/user_chapter_read_history.dart';
import 'package:shounengaming_mangas_mobile/src/features/user_profile/providers/user_profile.providers.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/date_helper.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

class UserActivityListScreen extends StatefulWidget {
  final int userId;
  UserActivityListScreen(this.userId, {super.key});

  @override
  State<UserActivityListScreen> createState() => _UserActivityListScreenState();
}

class _UserActivityListScreenState extends State<UserActivityListScreen> {
  int? _openIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, child) {
            return ref.watch(userActivityListProvider(widget.userId)).when(
                  data: (data) => ExpansionPanelList(
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (panelIndex, isExpanded) {
                      setState(() {
                        _openIndex = isExpanded ? null : panelIndex;
                      });
                    },
                    animationDuration: Duration(milliseconds: 800),
                    dividerColor: palette[1],
                    children: [
                      ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return Container(
                              padding: EdgeInsets.only(left: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('This Week')],
                              ),
                            );
                          },
                          body: Column(
                              children: data
                                  .where((activity) => activity.readAt.isAfter(
                                      DateTime.now().add(Duration(days: -7))))
                                  .map((e) => ActivityListCard(e))
                                  .toList()),
                          isExpanded: _openIndex == 0,
                          canTapOnHeader: true),
                      ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return Container(
                              padding: EdgeInsets.only(left: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('Last Month')],
                              ),
                            );
                          },
                          body: Column(
                              children: data
                                  .where((activity) =>
                                      activity.readAt.isBefore(DateTime.now()
                                          .add(Duration(days: -7))) &&
                                      activity.readAt.isAfter(DateTime.now()
                                          .add(Duration(days: -30))))
                                  .map((e) => ActivityListCard(e))
                                  .toList()),
                          isExpanded: _openIndex == 1,
                          canTapOnHeader: true),
                      ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return Container(
                              padding: EdgeInsets.only(left: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('Last Year')],
                              ),
                            );
                          },
                          body: Column(
                              children: data
                                  .where((activity) =>
                                      activity.readAt.isBefore(DateTime.now()
                                          .add(Duration(days: -30))) &&
                                      activity.readAt.isAfter(DateTime.now()
                                          .add(Duration(days: -365))))
                                  .map((e) => ActivityListCard(e))
                                  .toList()),
                          isExpanded: _openIndex == 2,
                          canTapOnHeader: true),
                      ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return Container(
                              padding: EdgeInsets.only(left: 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('Previous Years')],
                              ),
                            );
                          },
                          body: Column(
                              children: data
                                  .where((activity) => activity.readAt.isBefore(
                                      DateTime.now().add(Duration(days: -365))))
                                  .map((e) => ActivityListCard(e))
                                  .toList()),
                          isExpanded: _openIndex == 3,
                          canTapOnHeader: true),
                    ],
                  ),
                  error: (error, stackTrace) => Column(
                    children: [Text(error.toString())],
                  ),
                  loading: () => Column(
                    children: [LinearProgressIndicator()],
                  ),
                );
          },
        ),
      ),
    );
  }
}

class ActivityListCard extends StatelessWidget {
  final UserChapterReadHistory chapterReadHistory;
  const ActivityListCard(this.chapterReadHistory, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: Color.fromARGB(122, 55, 55, 55),
          borderRadius: BorderRadius.circular(4)),
      height: 60,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: 40,
                imageUrl: chapterReadHistory.manga.imagesUrls[0]),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(children: [
                TextSpan(
                    style: TextStyle(color: Colors.white.withOpacity(0.75)),
                    text: chapterReadHistory.numOfLastChapter != null &&
                            chapterReadHistory.numOfLastChapter !=
                                chapterReadHistory.numOfFirstChapter
                        ? 'Read chapters ${chapterReadHistory.numOfFirstChapter} - ${chapterReadHistory.numOfLastChapter} of '
                        : 'Read chapter ${chapterReadHistory.numOfFirstChapter} of '),
                TextSpan(
                    style: TextStyle(
                        color: palette[2], fontWeight: FontWeight.w500),
                    text: chapterReadHistory.manga.name)
              ]),
            ),
          )),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Tooltip(
                  message: DateFormat("dd/MM/yyyy HH:mm")
                      .format(chapterReadHistory.readAt.toLocal()),
                  child: Text(
                    howMuchHasPassed(chapterReadHistory.readAt.toLocal()),
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 13,
          ),
        ],
      ),
    );
  }
}
