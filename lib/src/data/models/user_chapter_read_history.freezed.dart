// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_chapter_read_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserChapterReadHistory _$UserChapterReadHistoryFromJson(
    Map<String, dynamic> json) {
  return _UserChapterReadHistory.fromJson(json);
}

/// @nodoc
mixin _$UserChapterReadHistory {
  DateTime get readAt => throw _privateConstructorUsedError;
  num get numOfFirstChapter => throw _privateConstructorUsedError;
  num? get numOfLastChapter => throw _privateConstructorUsedError;
  MangaInfo get manga => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserChapterReadHistoryCopyWith<UserChapterReadHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserChapterReadHistoryCopyWith<$Res> {
  factory $UserChapterReadHistoryCopyWith(UserChapterReadHistory value,
          $Res Function(UserChapterReadHistory) then) =
      _$UserChapterReadHistoryCopyWithImpl<$Res, UserChapterReadHistory>;
  @useResult
  $Res call(
      {DateTime readAt,
      num numOfFirstChapter,
      num? numOfLastChapter,
      MangaInfo manga});

  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class _$UserChapterReadHistoryCopyWithImpl<$Res,
        $Val extends UserChapterReadHistory>
    implements $UserChapterReadHistoryCopyWith<$Res> {
  _$UserChapterReadHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? readAt = null,
    Object? numOfFirstChapter = null,
    Object? numOfLastChapter = freezed,
    Object? manga = null,
  }) {
    return _then(_value.copyWith(
      readAt: null == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      numOfFirstChapter: null == numOfFirstChapter
          ? _value.numOfFirstChapter
          : numOfFirstChapter // ignore: cast_nullable_to_non_nullable
              as num,
      numOfLastChapter: freezed == numOfLastChapter
          ? _value.numOfLastChapter
          : numOfLastChapter // ignore: cast_nullable_to_non_nullable
              as num?,
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MangaInfoCopyWith<$Res> get manga {
    return $MangaInfoCopyWith<$Res>(_value.manga, (value) {
      return _then(_value.copyWith(manga: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserChapterReadHistoryImplCopyWith<$Res>
    implements $UserChapterReadHistoryCopyWith<$Res> {
  factory _$$UserChapterReadHistoryImplCopyWith(
          _$UserChapterReadHistoryImpl value,
          $Res Function(_$UserChapterReadHistoryImpl) then) =
      __$$UserChapterReadHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime readAt,
      num numOfFirstChapter,
      num? numOfLastChapter,
      MangaInfo manga});

  @override
  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class __$$UserChapterReadHistoryImplCopyWithImpl<$Res>
    extends _$UserChapterReadHistoryCopyWithImpl<$Res,
        _$UserChapterReadHistoryImpl>
    implements _$$UserChapterReadHistoryImplCopyWith<$Res> {
  __$$UserChapterReadHistoryImplCopyWithImpl(
      _$UserChapterReadHistoryImpl _value,
      $Res Function(_$UserChapterReadHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? readAt = null,
    Object? numOfFirstChapter = null,
    Object? numOfLastChapter = freezed,
    Object? manga = null,
  }) {
    return _then(_$UserChapterReadHistoryImpl(
      readAt: null == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      numOfFirstChapter: null == numOfFirstChapter
          ? _value.numOfFirstChapter
          : numOfFirstChapter // ignore: cast_nullable_to_non_nullable
              as num,
      numOfLastChapter: freezed == numOfLastChapter
          ? _value.numOfLastChapter
          : numOfLastChapter // ignore: cast_nullable_to_non_nullable
              as num?,
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChapterReadHistoryImpl implements _UserChapterReadHistory {
  _$UserChapterReadHistoryImpl(
      {required this.readAt,
      required this.numOfFirstChapter,
      this.numOfLastChapter,
      required this.manga});

  factory _$UserChapterReadHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserChapterReadHistoryImplFromJson(json);

  @override
  final DateTime readAt;
  @override
  final num numOfFirstChapter;
  @override
  final num? numOfLastChapter;
  @override
  final MangaInfo manga;

  @override
  String toString() {
    return 'UserChapterReadHistory(readAt: $readAt, numOfFirstChapter: $numOfFirstChapter, numOfLastChapter: $numOfLastChapter, manga: $manga)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChapterReadHistoryImpl &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.numOfFirstChapter, numOfFirstChapter) ||
                other.numOfFirstChapter == numOfFirstChapter) &&
            (identical(other.numOfLastChapter, numOfLastChapter) ||
                other.numOfLastChapter == numOfLastChapter) &&
            (identical(other.manga, manga) || other.manga == manga));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, readAt, numOfFirstChapter, numOfLastChapter, manga);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChapterReadHistoryImplCopyWith<_$UserChapterReadHistoryImpl>
      get copyWith => __$$UserChapterReadHistoryImplCopyWithImpl<
          _$UserChapterReadHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChapterReadHistoryImplToJson(
      this,
    );
  }
}

abstract class _UserChapterReadHistory implements UserChapterReadHistory {
  factory _UserChapterReadHistory(
      {required final DateTime readAt,
      required final num numOfFirstChapter,
      final num? numOfLastChapter,
      required final MangaInfo manga}) = _$UserChapterReadHistoryImpl;

  factory _UserChapterReadHistory.fromJson(Map<String, dynamic> json) =
      _$UserChapterReadHistoryImpl.fromJson;

  @override
  DateTime get readAt;
  @override
  num get numOfFirstChapter;
  @override
  num? get numOfLastChapter;
  @override
  MangaInfo get manga;
  @override
  @JsonKey(ignore: true)
  _$$UserChapterReadHistoryImplCopyWith<_$UserChapterReadHistoryImpl>
      get copyWith => throw _privateConstructorUsedError;
}
