import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/user_manga_main_stats.dart';

import '../models/user_chapter_read_history.dart';

final mangaUsersStatsRepositoryProvider =
    Provider<MangaUsersStatsRepository>((ref) {
  final dio = ref.read(dioProvider);
  return MangaUsersStatsRepository(dio);
});

class MangaUsersStatsRepository {
  final Dio _client;
  static const String _baseURL = "api/mangas";

  MangaUsersStatsRepository(this._client);

  Future<UserMangaMainStats> getUserMainStats(
    int userId,
  ) async {
    var response = await _client.get('$_baseURL/user/$userId/stats/main');
    return UserMangaMainStats.fromJson(response.data);
  }

  Future<List<UserChapterReadHistory>> getMangaDataByStatusByUser(
      int userId) async {
    var response = await _client.get('$_baseURL/user/$userId/stats/history');
    return (response.data as List)
        .map((m) => UserChapterReadHistory.fromJson(m))
        .toList();
  }
}
