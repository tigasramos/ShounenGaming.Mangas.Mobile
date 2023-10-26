// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MangaSourceImpl _$$MangaSourceImplFromJson(Map<String, dynamic> json) =>
    _$MangaSourceImpl(
      name: json['name'] as String,
      source: $enumDecode(_$MangaSourceEnumEnumMap, json['source']),
      url: json['url'] as String,
      imageURL: json['imageURL'] as String?,
    );

Map<String, dynamic> _$$MangaSourceImplToJson(_$MangaSourceImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'source': _$MangaSourceEnumEnumMap[instance.source]!,
      'url': instance.url,
      'imageURL': instance.imageURL,
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
