import 'dart:convert';

import 'package:flutter/foundation.dart';

class MALManga {
  int malId;
  String url;
  String title;
  String titleEnglish;
  String titleJapanese;
  List<String> titleSynonyms;
  List<TitleEntry> titles;
  ImageSet? images;
  String status;
  String type;
  int? volumes;
  int? chapters;
  bool publishing;
  TimePeriod published;
  int? score;
  int? scoredBy;
  int? rank;
  int? popularity;
  int? members;
  int? favorites;
  String synopsis;
  String background;
  List<MalUrl> genres;
  List<MalUrl> authors;
  List<MalUrl> serializations;
  List<MalUrl> explicitGenres;
  List<MalUrl> themes;
  List<MalUrl> demographics;
  bool approved;
  MALManga({
    required this.malId,
    required this.url,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.titleSynonyms,
    required this.titles,
    this.images,
    required this.status,
    required this.type,
    this.volumes,
    this.chapters,
    required this.publishing,
    required this.published,
    this.score,
    this.scoredBy,
    this.rank,
    this.popularity,
    this.members,
    this.favorites,
    required this.synopsis,
    required this.background,
    required this.genres,
    required this.authors,
    required this.serializations,
    required this.explicitGenres,
    required this.themes,
    required this.demographics,
    required this.approved,
  });

  MALManga copyWith({
    int? malId,
    String? url,
    String? title,
    String? titleEnglish,
    String? titleJapanese,
    List<String>? titleSynonyms,
    List<TitleEntry>? titles,
    ImageSet? images,
    String? status,
    String? type,
    int? volumes,
    int? chapters,
    bool? publishing,
    TimePeriod? published,
    int? score,
    int? scoredBy,
    int? rank,
    int? popularity,
    int? members,
    int? favorites,
    String? synopsis,
    String? background,
    List<MalUrl>? genres,
    List<MalUrl>? authors,
    List<MalUrl>? serializations,
    List<MalUrl>? explicitGenres,
    List<MalUrl>? themes,
    List<MalUrl>? demographics,
    bool? approved,
  }) {
    return MALManga(
      malId: malId ?? this.malId,
      url: url ?? this.url,
      title: title ?? this.title,
      titleEnglish: titleEnglish ?? this.titleEnglish,
      titleJapanese: titleJapanese ?? this.titleJapanese,
      titleSynonyms: titleSynonyms ?? this.titleSynonyms,
      titles: titles ?? this.titles,
      images: images ?? this.images,
      status: status ?? this.status,
      type: type ?? this.type,
      volumes: volumes ?? this.volumes,
      chapters: chapters ?? this.chapters,
      publishing: publishing ?? this.publishing,
      published: published ?? this.published,
      score: score ?? this.score,
      scoredBy: scoredBy ?? this.scoredBy,
      rank: rank ?? this.rank,
      popularity: popularity ?? this.popularity,
      members: members ?? this.members,
      favorites: favorites ?? this.favorites,
      synopsis: synopsis ?? this.synopsis,
      background: background ?? this.background,
      genres: genres ?? this.genres,
      authors: authors ?? this.authors,
      serializations: serializations ?? this.serializations,
      explicitGenres: explicitGenres ?? this.explicitGenres,
      themes: themes ?? this.themes,
      demographics: demographics ?? this.demographics,
      approved: approved ?? this.approved,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'malId': malId,
      'url': url,
      'title': title,
      'titleEnglish': titleEnglish,
      'titleJapanese': titleJapanese,
      'titleSynonyms': titleSynonyms,
      'titles': titles.map((x) => x.toMap()).toList(),
      'images': images?.toMap(),
      'status': status,
      'type': type,
      'volumes': volumes,
      'chapters': chapters,
      'publishing': publishing,
      'published': published.toMap(),
      'score': score,
      'scoredBy': scoredBy,
      'rank': rank,
      'popularity': popularity,
      'members': members,
      'favorites': favorites,
      'synopsis': synopsis,
      'background': background,
      'genres': genres.map((x) => x.toMap()).toList(),
      'authors': authors.map((x) => x.toMap()).toList(),
      'serializations': serializations.map((x) => x.toMap()).toList(),
      'explicitGenres': explicitGenres.map((x) => x.toMap()).toList(),
      'themes': themes.map((x) => x.toMap()).toList(),
      'demographics': demographics.map((x) => x.toMap()).toList(),
      'approved': approved,
    };
  }

  factory MALManga.fromMap(Map<String, dynamic> map) {
    return MALManga(
      malId: map['malId'] as int,
      url: map['url'] as String,
      title: map['title'] as String,
      titleEnglish: map['titleEnglish'] as String,
      titleJapanese: map['titleJapanese'] as String,
      titleSynonyms: List<String>.from((map['titleSynonyms'] as List<String>)),
      titles: List<TitleEntry>.from(
        (map['titles'] as List<int>).map<TitleEntry>(
          (x) => TitleEntry.fromMap(x as Map<String, dynamic>),
        ),
      ),
      images: map['images'] != null
          ? ImageSet.fromMap(map['images'] as Map<String, dynamic>)
          : null,
      status: map['status'] as String,
      type: map['type'] as String,
      volumes: map['volumes'] != null ? map['volumes'] as int : null,
      chapters: map['chapters'] != null ? map['chapters'] as int : null,
      publishing: map['publishing'] as bool,
      published: TimePeriod.fromMap(map['published'] as Map<String, dynamic>),
      score: map['score'] != null ? map['score'] as int : null,
      scoredBy: map['scoredBy'] != null ? map['scoredBy'] as int : null,
      rank: map['rank'] != null ? map['rank'] as int : null,
      popularity: map['popularity'] != null ? map['popularity'] as int : null,
      members: map['members'] != null ? map['members'] as int : null,
      favorites: map['favorites'] != null ? map['favorites'] as int : null,
      synopsis: map['synopsis'] as String,
      background: map['background'] as String,
      genres: List<MalUrl>.from(
        (map['genres'] as List<int>).map<MalUrl>(
          (x) => MalUrl.fromMap(x as Map<String, dynamic>),
        ),
      ),
      authors: List<MalUrl>.from(
        (map['authors'] as List<int>).map<MalUrl>(
          (x) => MalUrl.fromMap(x as Map<String, dynamic>),
        ),
      ),
      serializations: List<MalUrl>.from(
        (map['serializations'] as List<int>).map<MalUrl>(
          (x) => MalUrl.fromMap(x as Map<String, dynamic>),
        ),
      ),
      explicitGenres: List<MalUrl>.from(
        (map['explicitGenres'] as List<int>).map<MalUrl>(
          (x) => MalUrl.fromMap(x as Map<String, dynamic>),
        ),
      ),
      themes: List<MalUrl>.from(
        (map['themes'] as List<int>).map<MalUrl>(
          (x) => MalUrl.fromMap(x as Map<String, dynamic>),
        ),
      ),
      demographics: List<MalUrl>.from(
        (map['demographics'] as List<int>).map<MalUrl>(
          (x) => MalUrl.fromMap(x as Map<String, dynamic>),
        ),
      ),
      approved: map['approved'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MALManga.fromJson(String source) =>
      MALManga.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MALManga(malId: $malId, url: $url, title: $title, titleEnglish: $titleEnglish, titleJapanese: $titleJapanese, titleSynonyms: $titleSynonyms, titles: $titles, images: $images, status: $status, type: $type, volumes: $volumes, chapters: $chapters, publishing: $publishing, published: $published, score: $score, scoredBy: $scoredBy, rank: $rank, popularity: $popularity, members: $members, favorites: $favorites, synopsis: $synopsis, background: $background, genres: $genres, authors: $authors, serializations: $serializations, explicitGenres: $explicitGenres, themes: $themes, demographics: $demographics, approved: $approved)';
  }

  @override
  bool operator ==(covariant MALManga other) {
    if (identical(this, other)) return true;

    return other.malId == malId &&
        other.url == url &&
        other.title == title &&
        other.titleEnglish == titleEnglish &&
        other.titleJapanese == titleJapanese &&
        listEquals(other.titleSynonyms, titleSynonyms) &&
        listEquals(other.titles, titles) &&
        other.images == images &&
        other.status == status &&
        other.type == type &&
        other.volumes == volumes &&
        other.chapters == chapters &&
        other.publishing == publishing &&
        other.published == published &&
        other.score == score &&
        other.scoredBy == scoredBy &&
        other.rank == rank &&
        other.popularity == popularity &&
        other.members == members &&
        other.favorites == favorites &&
        other.synopsis == synopsis &&
        other.background == background &&
        listEquals(other.genres, genres) &&
        listEquals(other.authors, authors) &&
        listEquals(other.serializations, serializations) &&
        listEquals(other.explicitGenres, explicitGenres) &&
        listEquals(other.themes, themes) &&
        listEquals(other.demographics, demographics) &&
        other.approved == approved;
  }

  @override
  int get hashCode {
    return malId.hashCode ^
        url.hashCode ^
        title.hashCode ^
        titleEnglish.hashCode ^
        titleJapanese.hashCode ^
        titleSynonyms.hashCode ^
        titles.hashCode ^
        images.hashCode ^
        status.hashCode ^
        type.hashCode ^
        volumes.hashCode ^
        chapters.hashCode ^
        publishing.hashCode ^
        published.hashCode ^
        score.hashCode ^
        scoredBy.hashCode ^
        rank.hashCode ^
        popularity.hashCode ^
        members.hashCode ^
        favorites.hashCode ^
        synopsis.hashCode ^
        background.hashCode ^
        genres.hashCode ^
        authors.hashCode ^
        serializations.hashCode ^
        explicitGenres.hashCode ^
        themes.hashCode ^
        demographics.hashCode ^
        approved.hashCode;
  }
}

class TitleEntry {
  String type;
  String title;
  TitleEntry({
    required this.type,
    required this.title,
  });

  TitleEntry copyWith({
    String? type,
    String? title,
  }) {
    return TitleEntry(
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'title': title,
    };
  }

  factory TitleEntry.fromMap(Map<String, dynamic> map) {
    return TitleEntry(
      type: map['type'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TitleEntry.fromJson(String source) =>
      TitleEntry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TitleEntry(type: $type, title: $title)';

  @override
  bool operator ==(covariant TitleEntry other) {
    if (identical(this, other)) return true;

    return other.type == type && other.title == title;
  }

  @override
  int get hashCode => type.hashCode ^ title.hashCode;
}

class ImageSet {
  Image jpg;
  Image webp;
  ImageSet({
    required this.jpg,
    required this.webp,
  });

  ImageSet copyWith({
    Image? jpg,
    Image? webp,
  }) {
    return ImageSet(
      jpg: jpg ?? this.jpg,
      webp: webp ?? this.webp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jpg': jpg.toMap(),
      'webp': webp.toMap(),
    };
  }

  factory ImageSet.fromMap(Map<String, dynamic> map) {
    return ImageSet(
      jpg: Image.fromMap(map['jpg'] as Map<String, dynamic>),
      webp: Image.fromMap(map['webp'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageSet.fromJson(String source) =>
      ImageSet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageSet(jpg: $jpg, webp: $webp)';

  @override
  bool operator ==(covariant ImageSet other) {
    if (identical(this, other)) return true;

    return other.jpg == jpg && other.webp == webp;
  }

  @override
  int get hashCode => jpg.hashCode ^ webp.hashCode;
}

class Image {
  String imageUrl;
  String smallImageUrl;
  String mediumImageUrl;
  String largeImageUrl;
  String maximumImageUrl;
  Image({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.mediumImageUrl,
    required this.largeImageUrl,
    required this.maximumImageUrl,
  });

  Image copyWith({
    String? imageUrl,
    String? smallImageUrl,
    String? mediumImageUrl,
    String? largeImageUrl,
    String? maximumImageUrl,
  }) {
    return Image(
      imageUrl: imageUrl ?? this.imageUrl,
      smallImageUrl: smallImageUrl ?? this.smallImageUrl,
      mediumImageUrl: mediumImageUrl ?? this.mediumImageUrl,
      largeImageUrl: largeImageUrl ?? this.largeImageUrl,
      maximumImageUrl: maximumImageUrl ?? this.maximumImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'smallImageUrl': smallImageUrl,
      'mediumImageUrl': mediumImageUrl,
      'largeImageUrl': largeImageUrl,
      'maximumImageUrl': maximumImageUrl,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      imageUrl: map['imageUrl'] as String,
      smallImageUrl: map['smallImageUrl'] as String,
      mediumImageUrl: map['mediumImageUrl'] as String,
      largeImageUrl: map['largeImageUrl'] as String,
      maximumImageUrl: map['maximumImageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) =>
      Image.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Image(imageUrl: $imageUrl, smallImageUrl: $smallImageUrl, mediumImageUrl: $mediumImageUrl, largeImageUrl: $largeImageUrl, maximumImageUrl: $maximumImageUrl)';
  }

  @override
  bool operator ==(covariant Image other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl &&
        other.smallImageUrl == smallImageUrl &&
        other.mediumImageUrl == mediumImageUrl &&
        other.largeImageUrl == largeImageUrl &&
        other.maximumImageUrl == maximumImageUrl;
  }

  @override
  int get hashCode {
    return imageUrl.hashCode ^
        smallImageUrl.hashCode ^
        mediumImageUrl.hashCode ^
        largeImageUrl.hashCode ^
        maximumImageUrl.hashCode;
  }
}

class TimePeriod {
  DateTime? from;
  DateTime? to;
  TimePeriod({
    this.from,
    this.to,
  });

  TimePeriod copyWith({
    DateTime? from,
    DateTime? to,
  }) {
    return TimePeriod(
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from?.toString(),
      'to': to?.toString(),
    };
  }

  factory TimePeriod.fromMap(Map<String, dynamic> map) {
    return TimePeriod(
      from: map['from'] != null ? DateTime.parse(map['from']) : null,
      to: map['to'] != null ? DateTime.parse(map['to']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimePeriod.fromJson(String source) =>
      TimePeriod.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TimePeriod(from: $from, to: $to)';

  @override
  bool operator ==(covariant TimePeriod other) {
    if (identical(this, other)) return true;

    return other.from == from && other.to == to;
  }

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}

class MalUrl {
  int malId;
  String type;
  String url;
  String name;
  MalUrl({
    required this.malId,
    required this.type,
    required this.url,
    required this.name,
  });

  MalUrl copyWith({
    int? malId,
    String? type,
    String? url,
    String? name,
  }) {
    return MalUrl(
      malId: malId ?? this.malId,
      type: type ?? this.type,
      url: url ?? this.url,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'malId': malId,
      'type': type,
      'url': url,
      'name': name,
    };
  }

  factory MalUrl.fromMap(Map<String, dynamic> map) {
    return MalUrl(
      malId: map['malId'] as int,
      type: map['type'] as String,
      url: map['url'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MalUrl.fromJson(String source) =>
      MalUrl.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MalUrl(malId: $malId, type: $type, url: $url, name: $name)';
  }

  @override
  bool operator ==(covariant MalUrl other) {
    if (identical(this, other)) return true;

    return other.malId == malId &&
        other.type == type &&
        other.url == url &&
        other.name == name;
  }

  @override
  int get hashCode {
    return malId.hashCode ^ type.hashCode ^ url.hashCode ^ name.hashCode;
  }
}
