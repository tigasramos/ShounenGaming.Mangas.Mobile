import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shounengaming_mangas_mobile/main.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/manga_user_activity.dart';

import '../models/enums/manga_user_status_enum.dart';
import '../models/manga_user_data.dart';

final mangaUsersRepositoryProvider = Provider<MangaUsersRepository>((ref) {
  final dio = ref.read(dioProvider);
  return MangaUsersRepository(dio);
});

class MangaUsersRepository {
  final Dio _client;
  static const String _baseURL = "api/mangas";

  MangaUsersRepository(this._client);

  Future<List<MangaUserData>> getMangaDataByStatusByUser(
      int userId, MangaUserStatusEnum status) async {
    var response =
        await _client.get('$_baseURL/user/$userId/status/${status.name}');
    return (response.data as List)
        .map((m) => MangaUserData.fromJson(m))
        .toList();
  }

  Future<MangaUserData?> getDataByMangaByUser(int mangaId, int userId) async {
    var response = await _client.get('$_baseURL/$mangaId/user/$userId');
    if (response.statusCode == 200) {
      return MangaUserData.fromJson(response.data);
    }

    return null;
  }

  Future<MangaUserData> markChaptersRead(List<int> chaptersIds) async {
    var response = await _client.put('$_baseURL/read',
        data: chaptersIds, options: Options(contentType: 'application/json'));
    return MangaUserData.fromJson(response.data);
  }

  Future<MangaUserData?> unmarkChaptersRead(List<int> chaptersIds) async {
    var response = await _client.put('$_baseURL/unread',
        data: chaptersIds, options: Options(contentType: 'application/json'));
    if (response.data != null) {
      return MangaUserData.fromJson(response.data);
    }
    return null;
  }

  Future<MangaUserData?> updateMangaStatusByUser(
      int mangaId, MangaUserStatusEnum? status) async {
    var response = await _client.put(
        '$_baseURL/$mangaId/status?${status != null ? 'status=${status.name}' : ''}');
    if (response.data == null) return null;
    return MangaUserData.fromJson(response.data);
  }

  Future<MangaUserData?> updateMangaRatingByUser(
      int mangaId, double? rating) async {
    var response = await _client.put(
        '$_baseURL/$mangaId/rating?${rating != null ? 'rating=$rating' : ''}');
    if (response.data == null) return null;
    return MangaUserData.fromJson(response.data);
  }

  Future<List<MangaUserActivity>> getCommunityActivity() async {
    var response = await _client.get('$_baseURL/activities');
    return (response.data as List)
        .map((m) => MangaUserActivity.fromJson(m))
        .toList();
  }
}
