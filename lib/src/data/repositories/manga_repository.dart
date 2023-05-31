import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/translation_language_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_translation.dart';

import '../models/chapter_release.dart';
import '../models/mal_manga.dart';
import '../models/manga.dart';
import '../models/manga_info.dart';
import '../models/manga_writer.dart';
import '../models/paginated_manga_response.dart';
import '../models/scrapped_simple_manga.dart';

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

  Future<MangaTranslation> getMangaTranslation(
      int mangaId, int chapterId, TranslationLanguageEnum language) async {
    var response = await _client.get(
        '$_baseURL/$mangaId/chapters/$chapterId/translations/${language.name}');
    return MangaTranslation.fromMap(response.data);
  }

  Future<PaginatedMangaResponse> searchMangas(
      {String? name, List<String>? tags}) async {
    var response = await _client
        .get('$_baseURL/search', queryParameters: {'name': name, 'tags': tags});
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

  Future<MALManga> searchMangaMetaData(String name) async {
    var response = await _client
        .get('$_baseURL/search/myanimelist', queryParameters: {'name': name});
    return MALManga.fromMap(response.data);
  }

  Future<List<ScrappedSimpleManga>> searchMangaSource(String name) async {
    var response = await _client.get('$_baseURL/search/sources');
    return (response.data as List)
        .map((m) => ScrappedSimpleManga.fromMap(m))
        .toList();
  }

  Future<Manga> linkSourcesToManga(
      int myAnimeListId, List<ScrappedSimpleManga> mangas) async {
    var response =
        await _client.put('$_baseURL/$myAnimeListId/links', data: mangas);
    return Manga.fromMap(response.data);
  }
}
