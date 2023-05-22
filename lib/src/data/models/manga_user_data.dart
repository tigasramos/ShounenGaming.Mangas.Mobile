import 'dart:convert';

class MangaUserData {
  int userId;
  int mangaId;
  MangaUserData({
    required this.userId,
    required this.mangaId,
  });

  MangaUserData copyWith({
    int? userId,
    int? mangaId,
  }) {
    return MangaUserData(
      userId: userId ?? this.userId,
      mangaId: mangaId ?? this.mangaId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'mangaId': mangaId,
    };
  }

  factory MangaUserData.fromMap(Map<String, dynamic> map) {
    return MangaUserData(
      userId: map['userId'] as int,
      mangaId: map['mangaId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory MangaUserData.fromJson(String source) =>
      MangaUserData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MangaUserData(userId: $userId, mangaId: $mangaId)';

  @override
  bool operator ==(covariant MangaUserData other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.mangaId == mangaId;
  }

  @override
  int get hashCode => userId.hashCode ^ mangaId.hashCode;
}
