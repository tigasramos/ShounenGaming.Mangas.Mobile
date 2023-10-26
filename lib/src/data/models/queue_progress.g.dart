// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queue_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueProgressImpl _$$QueueProgressImplFromJson(Map<String, dynamic> json) =>
    _$QueueProgressImpl(
      percentage: (json['percentage'] as num).toDouble(),
      currentSource:
          $enumDecode(_$MangaSourceEnumEnumMap, json['currentSource']),
      currentChapter: json['currentChapter'] as int,
      totalChapters: json['totalChapters'] as int,
    );

Map<String, dynamic> _$$QueueProgressImplToJson(_$QueueProgressImpl instance) =>
    <String, dynamic>{
      'percentage': instance.percentage,
      'currentSource': _$MangaSourceEnumEnumMap[instance.currentSource]!,
      'currentChapter': instance.currentChapter,
      'totalChapters': instance.totalChapters,
    };

const _$MangaSourceEnumEnumMap = {
  MangaSourceEnum.GEKKOU_SCANS: 'GEKKOU_SCANS',
  MangaSourceEnum.NEO_X_SCANS: 'NEO_X_SCANS',
  MangaSourceEnum.MANGANATO: 'MANGANATO',
  MangaSourceEnum.SILENCE_SCANS: 'SILENCE_SCANS',
  MangaSourceEnum.HUNTERS_SCANS: 'HUNTERS_SCANS',
  MangaSourceEnum.BR_MANGAS: 'BR_MANGAS',
  MangaSourceEnum.MANGAS_CHAN: 'MANGAS_CHAN',
  MangaSourceEnum.DISKUS_SCAN: 'DISKUS_SCAN',
  MangaSourceEnum.UNION_MANGAS: 'UNION_MANGAS',
  MangaSourceEnum.YES_MANGAS: 'YES_MANGAS',
  MangaSourceEnum.MANGAS_DEX_PT: 'MANGAS_DEX_PT',
  MangaSourceEnum.MANGAS_DEX_EN: 'MANGAS_DEX_EN',
  MangaSourceEnum.MANGA_CLASH: 'MANGA_CLASH',
  MangaSourceEnum.RANDOM_SCAN: 'RANDOM_SCAN',
  MangaSourceEnum.SAIKAI_SCANS: 'SAIKAI_SCANS',
};
