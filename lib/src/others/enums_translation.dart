import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';

String translateMangaStatus(MangaUserStatusEnum? status) {
  switch (status) {
    case MangaUserStatusEnum.COMPLETED:
      return "Completed";
    case MangaUserStatusEnum.DROPPED:
      return "Dropped";
    case MangaUserStatusEnum.IGNORED:
      return "Ignored";
    case MangaUserStatusEnum.ON_HOLD:
      return "Paused";
    case MangaUserStatusEnum.PLANNED:
      return "Planned";
    case MangaUserStatusEnum.READING:
      return "Reading";
    default:
      return "";
  }
}
