import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_metadata_source_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/latest_release_manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_metadata.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_source.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_translation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/queued_manga.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/search_manga_query.dart';

import '../models/manga.dart';
import '../models/manga_info.dart';
import '../models/manga_writer.dart';
import '../models/paginated_manga_response.dart';

final mangaRepositoryProvider = Provider<MangaRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return MangaRepository(dio);
});

class MangaRepository {
  final Dio _client;
  static const String _baseURL = "api/mangas";

  MangaRepository(this._client);

  Future<Manga> getMangaById(int id) async {
    var response = await _client.get('$_baseURL/$id');
    return Manga.fromMap(response.data);
  }

  Future<List<MangaSource>> getMangaSourcesById(int id) async {
    var response = await _client.get('$_baseURL/$id/sources');
    return (response.data as List).map((m) => MangaSource.fromMap(m)).toList();
  }

  Future<MangaTranslation> getMangaTranslation(
      int mangaId, int chapterId, TranslationLanguageEnum language) async {
    var response = await _client.get(
        '$_baseURL/$mangaId/chapters/$chapterId/translations/${language.name}');
    return MangaTranslation.fromMap(response.data);
  }

  Future<PaginatedMangaResponse> searchMangas(
      SearchMangaQuery query, int page) async {
    var response = await _client.get(
      '$_baseURL/search?page=$page&name=${query.name}',
    );
    return PaginatedMangaResponse.fromMap(response.data);
  }

  Future<List<MangaInfo>> getFeaturedMangas() async {
    var response = await _client.get('$_baseURL/featured');
    return (response.data as List).map((m) => MangaInfo.fromMap(m)).toList();
  }

  Future<List<MangaInfo>> getWaitingMangas() async {
    var response = await _client.get('$_baseURL/waiting');
    return (response.data as List).map((m) => MangaInfo.fromMap(m)).toList();
  }

  Future<List<MangaInfo>> getSeasonMangas() async {
    var response = await _client.get('$_baseURL/season');
    return (response.data as List).map((m) => MangaInfo.fromMap(m)).toList();
  }

  Future<List<MangaInfo>> getPopularMangas() async {
    var response = await _client.get('$_baseURL/popular');
    return (response.data as List).map((m) => MangaInfo.fromMap(m)).toList();
  }

  Future<List<MangaInfo>> getRecentlyAddedMangas() async {
    var response = await _client.get('$_baseURL/recent');
    return (response.data as List).map((m) => MangaInfo.fromMap(m)).toList();
  }

  Future<List<LatestReleaseManga>> getRecentlyReleasedChapters() async {
    var response = await _client.get('$_baseURL/recent/chapters');
    return (response.data as List)
        .map((m) => LatestReleaseManga.fromMap(m))
        .toList();
  }

  Future<MangaWriter> getMangaWriterById(int id) async {
    var response = await _client.get('$_baseURL/writers/$id');
    return MangaWriter.fromMap(response.data);
  }

  Future<List<MangaWriter>> getMangaWriters() async {
    var response = await _client.get('$_baseURL/writers');
    return (response.data as List).map((m) => MangaWriter.fromMap(m)).toList();
  }

  Future<List<MangaInfo>> getMangasFromTag(String tag) async {
    var response = await _client.get('$_baseURL/tags/$tag');
    return (response.data as List).map((m) => MangaInfo.fromMap(m)).toList();
  }

  Future<List<String>> getMangaTags() async {
    var response = await _client.get('$_baseURL/tags');
    return (response.data as List).map((m) => m.toString()).toList();
  }

  Future<List<MangaSource>> searchMangaSource(String name) async {
    var response = await _client.get('$_baseURL/search/sources?name=$name');
    return (response.data as List).map((m) => MangaSource.fromMap(m)).toList();
  }

  Future<List<MangaSource>> linkSourcesToManga(
      int mangaId, List<MangaSource> mangas) async {
    var body = mangas.map((e) => e.toMap()).toList();
    var response = await _client.put('$_baseURL/$mangaId/links',
        data: body, options: Options(contentType: 'application/json'));
    return (response.data as List).map((m) => MangaSource.fromMap(m)).toList();
  }

  Future fetchChaptersForManga(int mangaId) async {
    var response = await _client.put('$_baseURL/$mangaId/chapters');
    if (response.statusCode != 200) {
      throw Exception("Status Code: ${response.statusCode}");
    }
  }

  Future<Manga> addManga(int mangaId, MangaMetadataSourceEnum source) async {
    var response = await _client.post(
      '$_baseURL/${source.name}/$mangaId',
    );
    return Manga.fromMap(response.data);
  }

  Future<List<MangaMetadata>> searchMangaMetadata(
      String name, MangaMetadataSourceEnum source) async {
    var response =
        await _client.get('$_baseURL/search/${source.name}?name=$name');
    return (response.data as List)
        .map((m) => MangaMetadata.fromMap(m))
        .toList();
  }

  Future<List<QueuedManga>> getQueueStatus() async {
    var response = await _client.get('$_baseURL/queue');
    return (response.data as List).map((m) => QueuedManga.fromMap(m)).toList();
  }
}
