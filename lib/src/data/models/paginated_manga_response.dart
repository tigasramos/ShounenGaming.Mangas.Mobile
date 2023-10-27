import 'package:freezed_annotation/freezed_annotation.dart';

import 'manga_info.dart';

part 'paginated_manga_response.freezed.dart';
part 'paginated_manga_response.g.dart';

@unfreezed
class PaginatedMangaResponse with _$PaginatedMangaResponse {
  factory PaginatedMangaResponse({
    required List<MangaInfo> data,
    required int currentPage,
    required int maxCount,
  }) = _PaginatedMangaResponse;

  factory PaginatedMangaResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedMangaResponseFromJson(json);
}
