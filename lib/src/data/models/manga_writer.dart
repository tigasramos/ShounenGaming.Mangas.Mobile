import 'package:freezed_annotation/freezed_annotation.dart';

part 'manga_writer.freezed.dart';
part 'manga_writer.g.dart';

@freezed
class MangaWriter with _$MangaWriter {
  factory MangaWriter({
    required int id,
    required String name,
  }) = _MangaWriter;

  factory MangaWriter.fromJson(Map<String, dynamic> json) =>
      _$MangaWriterFromJson(json);
}
