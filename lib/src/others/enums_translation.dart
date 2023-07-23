import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_source_enum.dart';
import 'package:shounengaming_mangas_mobile/src/data/models/enums/manga_user_status_enum.dart';
import 'package:shounengaming_mangas_mobile/src/features/chapter/chapter_screen.dart';

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

String translateMangaSource(MangaSourceEnum? source) {
  switch (source) {
    case MangaSourceEnum.BR_MANGAS:
      return "BR Mangas";
    case MangaSourceEnum.DISKUS_SCAN:
      return "Diskus Scans";
    case MangaSourceEnum.GEKKOU_SCANS:
      return "Gekkou Scans";
    case MangaSourceEnum.HUNTERS_SCANS:
      return "Hunters Scans";
    case MangaSourceEnum.MANGANATO:
      return "Manganato";
    case MangaSourceEnum.MANGAS_CHAN:
      return "Mangas Chan";
    case MangaSourceEnum.MANGAS_DEX_EN:
      return "Mangas Dex (Eng)";
    case MangaSourceEnum.MANGAS_DEX_PT:
      return "Mangas Dex (Pt)";
    case MangaSourceEnum.NEO_X_SCANS:
      return "NeoXScans";
    case MangaSourceEnum.SILENCE_SCANS:
      return "Silence Scans";
    case MangaSourceEnum.UNION_MANGAS:
      return "Union Mangas";
    case MangaSourceEnum.YES_MANGAS:
      return "Yes Mangas";
    default:
      return "";
  }
}

String translateReadingMode(ReadingDirectionEnum? readingMode) {
  switch (readingMode) {
    case ReadingDirectionEnum.HORIZONTAL_PAGED:
      return "Horizontal (Paged)";
    case ReadingDirectionEnum.VERTICAL:
      return "Vertical";
    case ReadingDirectionEnum.VERTICAL_PAGED:
      return "Vertical (Paged)";
    default:
      return "";
  }
}
