import 'package:dash_flags/dash_flags.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_type_enum.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/enums_translation.dart';
import 'package:shounengaming_mangas_mobile/src/shared/utils/theme.dart';

class MangaTypesPieChart extends StatefulWidget {
  final Map<MangaTypeEnum, int> mangaTypesStats;
  const MangaTypesPieChart(this.mangaTypesStats, {super.key});

  @override
  State<MangaTypesPieChart> createState() => _MangaTypesPieChartState();
}

class _MangaTypesPieChartState extends State<MangaTypesPieChart> {
  int? touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = null;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(context),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(BuildContext ctx) {
    var entries = widget.mangaTypesStats.entries;

    final totalValue =
        entries.map((e) => e.value).reduce((value, element) => value + element);
    final list = <PieChartSectionData>[];
    for (var i = 0; i < entries.length; i++) {
      final e = entries.elementAt(i);
      final isTouched = i == touchedIndex;

      final fontSize = MediaQuery.sizeOf(context).width / (isTouched ? 20 : 25);
      final radius =
          MediaQuery.sizeOf(context).width / (isTouched ? 3.25 : 3.75);
      final widgetSize =
          MediaQuery.sizeOf(context).width / (isTouched ? 7.5 : 9);
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      final color = i == 0
          ? palette[0]
          : i == 1
              ? palette[2]
              : palette[3];
      final value = e.value / totalValue * 100;
      final flag = getFlag(e.key);

      list.add(PieChartSectionData(
        color: color,
        value: value,
        title: '${value.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: _Badge(
          flag,
          size: widgetSize,
          borderColor: Colors.black,
        ),
        badgePositionPercentageOffset: .98,
      ));
    }
    return list;
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.country, {
    required this.size,
    required this.borderColor,
  });
  final Country country;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: palette[1],
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: CountryFlag(
          country: country,
          height: 18,
        ),
      ),
    );
  }
}
