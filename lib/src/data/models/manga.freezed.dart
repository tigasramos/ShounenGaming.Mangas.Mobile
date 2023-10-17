// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Manga _$MangaFromJson(Map<String, dynamic> json) {
  return _Manga.fromJson(json);
}

/// @nodoc
mixin _$Manga {
  int get id => throw _privateConstructorUsedError;
  set id(int value) => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  set name(String value) => throw _privateConstructorUsedError;
  List<StringPair> get alternativeNames => throw _privateConstructorUsedError;
  set alternativeNames(List<StringPair> value) =>
      throw _privateConstructorUsedError;
  List<String> get synonyms => throw _privateConstructorUsedError;
  set synonyms(List<String> value) => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  set description(String value) => throw _privateConstructorUsedError;
  bool get isReleasing => throw _privateConstructorUsedError;
  set isReleasing(bool value) => throw _privateConstructorUsedError;
  MangaTypeEnum get type => throw _privateConstructorUsedError;
  set type(MangaTypeEnum value) => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  set tags(List<String> value) => throw _privateConstructorUsedError;
  List<MangaChapter> get chapters => throw _privateConstructorUsedError;
  set chapters(List<MangaChapter> value) => throw _privateConstructorUsedError;
  List<String> get imagesUrls => throw _privateConstructorUsedError;
  set imagesUrls(List<String> value) => throw _privateConstructorUsedError;
  MangaWriter get writer => throw _privateConstructorUsedError;
  set writer(MangaWriter value) => throw _privateConstructorUsedError;
  double? get averageScore => throw _privateConstructorUsedError;
  set averageScore(double? value) => throw _privateConstructorUsedError;
  int? get mangaMyAnimeListId => throw _privateConstructorUsedError;
  set mangaMyAnimeListId(int? value) => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  set startedAt(DateTime? value) => throw _privateConstructorUsedError;
  DateTime? get finishedAt => throw _privateConstructorUsedError;
  set finishedAt(DateTime? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaCopyWith<Manga> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaCopyWith<$Res> {
  factory $MangaCopyWith(Manga value, $Res Function(Manga) then) =
      _$MangaCopyWithImpl<$Res, Manga>;
  @useResult
  $Res call(
      {int id,
      String name,
      List<StringPair> alternativeNames,
      List<String> synonyms,
      String description,
      bool isReleasing,
      MangaTypeEnum type,
      List<String> tags,
      List<MangaChapter> chapters,
      List<String> imagesUrls,
      MangaWriter writer,
      double? averageScore,
      int? mangaMyAnimeListId,
      DateTime? startedAt,
      DateTime? finishedAt});

  $MangaWriterCopyWith<$Res> get writer;
}

/// @nodoc
class _$MangaCopyWithImpl<$Res, $Val extends Manga>
    implements $MangaCopyWith<$Res> {
  _$MangaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? alternativeNames = null,
    Object? synonyms = null,
    Object? description = null,
    Object? isReleasing = null,
    Object? type = null,
    Object? tags = null,
    Object? chapters = null,
    Object? imagesUrls = null,
    Object? writer = null,
    Object? averageScore = freezed,
    Object? mangaMyAnimeListId = freezed,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      alternativeNames: null == alternativeNames
          ? _value.alternativeNames
          : alternativeNames // ignore: cast_nullable_to_non_nullable
              as List<StringPair>,
      synonyms: null == synonyms
          ? _value.synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isReleasing: null == isReleasing
          ? _value.isReleasing
          : isReleasing // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MangaTypeEnum,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      chapters: null == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<MangaChapter>,
      imagesUrls: null == imagesUrls
          ? _value.imagesUrls
          : imagesUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      writer: null == writer
          ? _value.writer
          : writer // ignore: cast_nullable_to_non_nullable
              as MangaWriter,
      averageScore: freezed == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double?,
      mangaMyAnimeListId: freezed == mangaMyAnimeListId
          ? _value.mangaMyAnimeListId
          : mangaMyAnimeListId // ignore: cast_nullable_to_non_nullable
              as int?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedAt: freezed == finishedAt
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MangaWriterCopyWith<$Res> get writer {
    return $MangaWriterCopyWith<$Res>(_value.writer, (value) {
      return _then(_value.copyWith(writer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MangaImplCopyWith<$Res> implements $MangaCopyWith<$Res> {
  factory _$$MangaImplCopyWith(
          _$MangaImpl value, $Res Function(_$MangaImpl) then) =
      __$$MangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      List<StringPair> alternativeNames,
      List<String> synonyms,
      String description,
      bool isReleasing,
      MangaTypeEnum type,
      List<String> tags,
      List<MangaChapter> chapters,
      List<String> imagesUrls,
      MangaWriter writer,
      double? averageScore,
      int? mangaMyAnimeListId,
      DateTime? startedAt,
      DateTime? finishedAt});

  @override
  $MangaWriterCopyWith<$Res> get writer;
}

/// @nodoc
class __$$MangaImplCopyWithImpl<$Res>
    extends _$MangaCopyWithImpl<$Res, _$MangaImpl>
    implements _$$MangaImplCopyWith<$Res> {
  __$$MangaImplCopyWithImpl(
      _$MangaImpl _value, $Res Function(_$MangaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? alternativeNames = null,
    Object? synonyms = null,
    Object? description = null,
    Object? isReleasing = null,
    Object? type = null,
    Object? tags = null,
    Object? chapters = null,
    Object? imagesUrls = null,
    Object? writer = null,
    Object? averageScore = freezed,
    Object? mangaMyAnimeListId = freezed,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
  }) {
    return _then(_$MangaImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      alternativeNames: null == alternativeNames
          ? _value.alternativeNames
          : alternativeNames // ignore: cast_nullable_to_non_nullable
              as List<StringPair>,
      synonyms: null == synonyms
          ? _value.synonyms
          : synonyms // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isReleasing: null == isReleasing
          ? _value.isReleasing
          : isReleasing // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MangaTypeEnum,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      chapters: null == chapters
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<MangaChapter>,
      imagesUrls: null == imagesUrls
          ? _value.imagesUrls
          : imagesUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      writer: null == writer
          ? _value.writer
          : writer // ignore: cast_nullable_to_non_nullable
              as MangaWriter,
      averageScore: freezed == averageScore
          ? _value.averageScore
          : averageScore // ignore: cast_nullable_to_non_nullable
              as double?,
      mangaMyAnimeListId: freezed == mangaMyAnimeListId
          ? _value.mangaMyAnimeListId
          : mangaMyAnimeListId // ignore: cast_nullable_to_non_nullable
              as int?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedAt: freezed == finishedAt
          ? _value.finishedAt
          : finishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaImpl implements _Manga {
  _$MangaImpl(
      {required this.id,
      required this.name,
      required this.alternativeNames,
      required this.synonyms,
      required this.description,
      required this.isReleasing,
      required this.type,
      required this.tags,
      required this.chapters,
      required this.imagesUrls,
      required this.writer,
      this.averageScore,
      this.mangaMyAnimeListId,
      this.startedAt,
      this.finishedAt});

  factory _$MangaImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaImplFromJson(json);

  @override
  int id;
  @override
  String name;
  @override
  List<StringPair> alternativeNames;
  @override
  List<String> synonyms;
  @override
  String description;
  @override
  bool isReleasing;
  @override
  MangaTypeEnum type;
  @override
  List<String> tags;
  @override
  List<MangaChapter> chapters;
  @override
  List<String> imagesUrls;
  @override
  MangaWriter writer;
  @override
  double? averageScore;
  @override
  int? mangaMyAnimeListId;
  @override
  DateTime? startedAt;
  @override
  DateTime? finishedAt;

  @override
  String toString() {
    return 'Manga(id: $id, name: $name, alternativeNames: $alternativeNames, synonyms: $synonyms, description: $description, isReleasing: $isReleasing, type: $type, tags: $tags, chapters: $chapters, imagesUrls: $imagesUrls, writer: $writer, averageScore: $averageScore, mangaMyAnimeListId: $mangaMyAnimeListId, startedAt: $startedAt, finishedAt: $finishedAt)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaImplCopyWith<_$MangaImpl> get copyWith =>
      __$$MangaImplCopyWithImpl<_$MangaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaImplToJson(
      this,
    );
  }
}

abstract class _Manga implements Manga {
  factory _Manga(
      {required int id,
      required String name,
      required List<StringPair> alternativeNames,
      required List<String> synonyms,
      required String description,
      required bool isReleasing,
      required MangaTypeEnum type,
      required List<String> tags,
      required List<MangaChapter> chapters,
      required List<String> imagesUrls,
      required MangaWriter writer,
      double? averageScore,
      int? mangaMyAnimeListId,
      DateTime? startedAt,
      DateTime? finishedAt}) = _$MangaImpl;

  factory _Manga.fromJson(Map<String, dynamic> json) = _$MangaImpl.fromJson;

  @override
  int get id;
  set id(int value);
  @override
  String get name;
  set name(String value);
  @override
  List<StringPair> get alternativeNames;
  set alternativeNames(List<StringPair> value);
  @override
  List<String> get synonyms;
  set synonyms(List<String> value);
  @override
  String get description;
  set description(String value);
  @override
  bool get isReleasing;
  set isReleasing(bool value);
  @override
  MangaTypeEnum get type;
  set type(MangaTypeEnum value);
  @override
  List<String> get tags;
  set tags(List<String> value);
  @override
  List<MangaChapter> get chapters;
  set chapters(List<MangaChapter> value);
  @override
  List<String> get imagesUrls;
  set imagesUrls(List<String> value);
  @override
  MangaWriter get writer;
  set writer(MangaWriter value);
  @override
  double? get averageScore;
  set averageScore(double? value);
  @override
  int? get mangaMyAnimeListId;
  set mangaMyAnimeListId(int? value);
  @override
  DateTime? get startedAt;
  set startedAt(DateTime? value);
  @override
  DateTime? get finishedAt;
  set finishedAt(DateTime? value);
  @override
  @JsonKey(ignore: true)
  _$$MangaImplCopyWith<_$MangaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
