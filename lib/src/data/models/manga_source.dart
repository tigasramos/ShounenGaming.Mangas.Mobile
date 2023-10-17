import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums/manga_source_enum.dart';

part 'manga_source.freezed.dart';
part 'manga_source.g.dart';

@freezed
class MangaSource with _$MangaSource {
  factory MangaSource({
    required String name,
    required MangaSourceEnum source,
    required String url,
    String? imageURL,
  }) = _MangaSource;

  factory MangaSource.fromJson(Map<String, dynamic> json) =>
      _$MangaSourceFromJson(json);
}
