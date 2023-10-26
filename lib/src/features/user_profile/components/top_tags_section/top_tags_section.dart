import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

class TopTagsSection extends StatelessWidget {
  final Map<String, int> tagsStats;
  const TopTagsSection(this.tagsStats, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Tags',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 33,
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(
                  width: 10,
                ),
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  padding:
                      EdgeInsets.only(top: 2, bottom: 2, left: 14, right: 14),
                  child: Row(
                    children: [
                      Text(
                        tagsStats.keys.elementAt(index),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "${tagsStats.values.elementAt(index)}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [palette[0], palette[1]],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft),
                      //color: palette[0],
                      borderRadius: BorderRadius.circular(6)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
