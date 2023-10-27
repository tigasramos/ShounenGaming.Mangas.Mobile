import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_manga_query.freezed.dart';
part 'search_manga_query.g.dart';

@freezed
class SearchMangaQuery with _$SearchMangaQuery {
  factory SearchMangaQuery({
    String? name,
  }) = _SearchMangaQuery;

  factory SearchMangaQuery.fromJson(Map<String, dynamic> json) =>
      _$SearchMangaQueryFromJson(json);
}
