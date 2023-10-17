// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'queued_manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueuedMangaImpl _$$QueuedMangaImplFromJson(Map<String, dynamic> json) =>
    _$QueuedMangaImpl(
      manga: MangaInfo.fromJson(json['manga'] as Map<String, dynamic>),
      progress: json['progress'] == null
          ? null
          : QueueProgress.fromJson(json['progress'] as Map<String, dynamic>),
      queuedByUser: json['queuedByUser'] == null
          ? null
          : SimpleUser.fromJson(json['queuedByUser'] as Map<String, dynamic>),
      queuedAt: DateTime.parse(json['queuedAt'] as String),
    );

Map<String, dynamic> _$$QueuedMangaImplToJson(_$QueuedMangaImpl instance) =>
    <String, dynamic>{
      'manga': instance.manga,
      'progress': instance.progress,
      'queuedByUser': instance.queuedByUser,
      'queuedAt': instance.queuedAt.toIso8601String(),
    };
