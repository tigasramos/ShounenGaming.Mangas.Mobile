import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/manga_metadata_source_enum.dart';

part 'manga_metadata.freezed.dart';
part 'manga_metadata.g.dart';

@freezed
class MangaMetadata with _$MangaMetadata {
  factory MangaMetadata({
    required int id,
    required MangaMetadataSourceEnum source,
    required List<String> titles,
    required String imageUrl,
    required bool alreadyExists,
    required String type,
    required String description,
    required String status,
    num? score,
    required List<String> tags,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) = _MangaMetadata;

  factory MangaMetadata.fromJson(Map<String, dynamic> json) =>
      _$MangaMetadataFromJson(json);
}
