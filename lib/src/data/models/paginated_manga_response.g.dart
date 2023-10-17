// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_manga_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginatedMangaResponseImpl _$$PaginatedMangaResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PaginatedMangaResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => MangaInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['currentPage'] as int,
      maxCount: json['maxCount'] as int,
    );

Map<String, dynamic> _$$PaginatedMangaResponseImplToJson(
        _$PaginatedMangaResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'currentPage': instance.currentPage,
      'maxCount': instance.maxCount,
    };
