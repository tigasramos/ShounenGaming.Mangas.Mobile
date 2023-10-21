// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';

class UserMangaStatusListParams {
  int userId;
  MangaUserStatusEnum status;
  UserMangaStatusListParams({
    required this.userId,
    required this.status,
  });

  @override
  bool operator ==(covariant UserMangaStatusListParams other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.status == status;
  }

  @override
  int get hashCode => userId.hashCode ^ status.hashCode;
}
