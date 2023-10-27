import 'package:flutter/material.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/constants.dart';

import '../../screens/user_status_list_screen.dart';

class StatusDistributionSection extends StatelessWidget {
  final int userId;
  final Map<MangaUserStatusEnum, int> mangaStatusStats;
  const StatusDistributionSection(this.mangaStatusStats, this.userId,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Container(
            height: 9,
            child: Row(
              children: [
                Expanded(
                    flex: mangaStatusStats[MangaUserStatusEnum.READING] ?? 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3),
                              bottomLeft: Radius.circular(3))),
                    )),
                Expanded(
                    flex: mangaStatusStats[MangaUserStatusEnum.ON_HOLD] ?? 1,
                    child: Container(
                      color: Colors.orange[600],
                    )),
                Expanded(
                    flex: mangaStatusStats[MangaUserStatusEnum.COMPLETED] ?? 1,
                    child: Container(
                      color: Colors.green[800],
                    )),
                Expanded(
                    flex: mangaStatusStats[MangaUserStatusEnum.DROPPED] ?? 1,
                    child: Container(
                      color: Colors.red[700],
                    )),
                Expanded(
                    flex: mangaStatusStats[MangaUserStatusEnum.PLANNED] ?? 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.purple[700],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(3),
                              topRight: Radius.circular(3))),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      navigationKey.currentState?.push(MaterialPageRoute(
                        builder: (context) => UserStatusListScreen(
                            userId, MangaUserStatusEnum.READING),
                      ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.blue[800],
                          borderRadius: BorderRadius.circular(4)),
                      child: Text('Reading'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            "${mangaStatusStats[MangaUserStatusEnum.READING] ?? 0}",
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontWeight: FontWeight.w700)),
                    TextSpan(text: ' mangas')
                  ])),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      navigationKey.currentState?.push(MaterialPageRoute(
                        builder: (context) => UserStatusListScreen(
                            userId, MangaUserStatusEnum.COMPLETED),
                      ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.green[800],
                          borderRadius: BorderRadius.circular(4)),
                      child: Text('Completed'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            "${mangaStatusStats[MangaUserStatusEnum.COMPLETED] ?? 0}",
                        style: TextStyle(
                            color: Colors.green[500],
                            fontWeight: FontWeight.w700)),
                    TextSpan(text: ' mangas')
                  ])),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      navigationKey.currentState?.push(MaterialPageRoute(
                        builder: (context) => UserStatusListScreen(
                            userId, MangaUserStatusEnum.PLANNED),
                      ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.purple[700],
                          borderRadius: BorderRadius.circular(4)),
                      child: Text('Planned'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            "${mangaStatusStats[MangaUserStatusEnum.PLANNED] ?? 0}",
                        style: TextStyle(
                            color: Colors.purple[400],
                            fontWeight: FontWeight.w700)),
                    TextSpan(text: ' mangas')
                  ])),
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      navigationKey.currentState?.push(MaterialPageRoute(
                        builder: (context) => UserStatusListScreen(
                            userId, MangaUserStatusEnum.ON_HOLD),
                      ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.orange[600],
                          borderRadius: BorderRadius.circular(4)),
                      child: Text('Paused'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            "${mangaStatusStats[MangaUserStatusEnum.ON_HOLD] ?? 0}",
                        style: TextStyle(
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w700)),
                    TextSpan(text: ' mangas')
                  ])),
                ],
              ),
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      navigationKey.currentState?.push(MaterialPageRoute(
                        builder: (context) => UserStatusListScreen(
                            userId, MangaUserStatusEnum.DROPPED),
                      ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 3),
                      decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(4)),
                      child: Text('Dropped'),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text:
                            "${mangaStatusStats[MangaUserStatusEnum.DROPPED] ?? 0}",
                        style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.w700)),
                    TextSpan(text: ' mangas')
                  ])),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
