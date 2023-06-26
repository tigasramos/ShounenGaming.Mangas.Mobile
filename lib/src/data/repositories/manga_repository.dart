import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_source.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_translation.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/search_manga_query.dart';

import '../models/chapter_release.dart';
import '../models/manga.dart';
import '../models/manga_info.dart';
import '../models/manga_writer.dart';
import '../models/paginated_manga_response.dart';

final mangaRepositoryProvider = Provider<MangaRepository>((ref) {
  final dio = ref.read(dioProvider);
  return MangaRepository(dio);
});

class MangaRepository {
  final Dio _client;
  static const String _baseURL = "mangas";

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
    var response = await _client.get('$_baseURL/search',
        queryParameters: {'page': page}, data: query.toMap());
    return PaginatedMangaResponse.fromMap(response.data);
  }

  Future<List<MangaInfo>> getPopularMangas() async {
    var response = await _client.get('$_baseURL/popular');
    return (response.data as List).map((m) => MangaInfo.fromMap(m)).toList();
  }

  Future<List<MangaInfo>> getRecentlyAddedMangas() async {
    var response = await _client.get('$_baseURL/recent');
    return (response.data as List).map((m) => MangaInfo.fromMap(m)).toList();
  }

  Future<List<ChapterRelease>> getRecentlyReleasedChapters() async {
    var response = await _client.get('$_baseURL/recent/chapters');
    return (response.data as List)
        .map((m) => ChapterRelease.fromMap(m))
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
    var response = await _client.put('$_baseURL/$mangaId/links', data: body);
    return (response.data as List).map((m) => MangaSource.fromMap(m)).toList();
  }

  Future fetchChaptersForManga(int mangaId) async {
    var response = await _client.put('$_baseURL/$mangaId/chapters');
    if (response.statusCode != 200) {
      throw Exception("Status Code: ${response.statusCode}");
    }
  }
}
