// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queued_manga.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QueuedManga _$QueuedMangaFromJson(Map<String, dynamic> json) {
  return _QueuedManga.fromJson(json);
}

/// @nodoc
mixin _$QueuedManga {
  MangaInfo get manga => throw _privateConstructorUsedError;
  QueueProgress? get progress => throw _privateConstructorUsedError;
  SimpleUser? get queuedByUser => throw _privateConstructorUsedError;
  DateTime get queuedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QueuedMangaCopyWith<QueuedManga> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueuedMangaCopyWith<$Res> {
  factory $QueuedMangaCopyWith(
          QueuedManga value, $Res Function(QueuedManga) then) =
      _$QueuedMangaCopyWithImpl<$Res, QueuedManga>;
  @useResult
  $Res call(
      {MangaInfo manga,
      QueueProgress? progress,
      SimpleUser? queuedByUser,
      DateTime queuedAt});

  $MangaInfoCopyWith<$Res> get manga;
  $QueueProgressCopyWith<$Res>? get progress;
  $SimpleUserCopyWith<$Res>? get queuedByUser;
}

/// @nodoc
class _$QueuedMangaCopyWithImpl<$Res, $Val extends QueuedManga>
    implements $QueuedMangaCopyWith<$Res> {
  _$QueuedMangaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manga = null,
    Object? progress = freezed,
    Object? queuedByUser = freezed,
    Object? queuedAt = null,
  }) {
    return _then(_value.copyWith(
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as QueueProgress?,
      queuedByUser: freezed == queuedByUser
          ? _value.queuedByUser
          : queuedByUser // ignore: cast_nullable_to_non_nullable
              as SimpleUser?,
      queuedAt: null == queuedAt
          ? _value.queuedAt
          : queuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MangaInfoCopyWith<$Res> get manga {
    return $MangaInfoCopyWith<$Res>(_value.manga, (value) {
      return _then(_value.copyWith(manga: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $QueueProgressCopyWith<$Res>? get progress {
    if (_value.progress == null) {
      return null;
    }

    return $QueueProgressCopyWith<$Res>(_value.progress!, (value) {
      return _then(_value.copyWith(progress: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SimpleUserCopyWith<$Res>? get queuedByUser {
    if (_value.queuedByUser == null) {
      return null;
    }

    return $SimpleUserCopyWith<$Res>(_value.queuedByUser!, (value) {
      return _then(_value.copyWith(queuedByUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueuedMangaImplCopyWith<$Res>
    implements $QueuedMangaCopyWith<$Res> {
  factory _$$QueuedMangaImplCopyWith(
          _$QueuedMangaImpl value, $Res Function(_$QueuedMangaImpl) then) =
      __$$QueuedMangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MangaInfo manga,
      QueueProgress? progress,
      SimpleUser? queuedByUser,
      DateTime queuedAt});

  @override
  $MangaInfoCopyWith<$Res> get manga;
  @override
  $QueueProgressCopyWith<$Res>? get progress;
  @override
  $SimpleUserCopyWith<$Res>? get queuedByUser;
}

/// @nodoc
class __$$QueuedMangaImplCopyWithImpl<$Res>
    extends _$QueuedMangaCopyWithImpl<$Res, _$QueuedMangaImpl>
    implements _$$QueuedMangaImplCopyWith<$Res> {
  __$$QueuedMangaImplCopyWithImpl(
      _$QueuedMangaImpl _value, $Res Function(_$QueuedMangaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manga = null,
    Object? progress = freezed,
    Object? queuedByUser = freezed,
    Object? queuedAt = null,
  }) {
    return _then(_$QueuedMangaImpl(
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as QueueProgress?,
      queuedByUser: freezed == queuedByUser
          ? _value.queuedByUser
          : queuedByUser // ignore: cast_nullable_to_non_nullable
              as SimpleUser?,
      queuedAt: null == queuedAt
          ? _value.queuedAt
          : queuedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueuedMangaImpl implements _QueuedManga {
  _$QueuedMangaImpl(
      {required this.manga,
      this.progress,
      this.queuedByUser,
      required this.queuedAt});

  factory _$QueuedMangaImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueuedMangaImplFromJson(json);

  @override
  final MangaInfo manga;
  @override
  final QueueProgress? progress;
  @override
  final SimpleUser? queuedByUser;
  @override
  final DateTime queuedAt;

  @override
  String toString() {
    return 'QueuedManga(manga: $manga, progress: $progress, queuedByUser: $queuedByUser, queuedAt: $queuedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueuedMangaImpl &&
            (identical(other.manga, manga) || other.manga == manga) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.queuedByUser, queuedByUser) ||
                other.queuedByUser == queuedByUser) &&
            (identical(other.queuedAt, queuedAt) ||
                other.queuedAt == queuedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, manga, progress, queuedByUser, queuedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueuedMangaImplCopyWith<_$QueuedMangaImpl> get copyWith =>
      __$$QueuedMangaImplCopyWithImpl<_$QueuedMangaImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueuedMangaImplToJson(
      this,
    );
  }
}

abstract class _QueuedManga implements QueuedManga {
  factory _QueuedManga(
      {required final MangaInfo manga,
      final QueueProgress? progress,
      final SimpleUser? queuedByUser,
      required final DateTime queuedAt}) = _$QueuedMangaImpl;

  factory _QueuedManga.fromJson(Map<String, dynamic> json) =
      _$QueuedMangaImpl.fromJson;

  @override
  MangaInfo get manga;
  @override
  QueueProgress? get progress;
  @override
  SimpleUser? get queuedByUser;
  @override
  DateTime get queuedAt;
  @override
  @JsonKey(ignore: true)
  _$$QueuedMangaImplCopyWith<_$QueuedMangaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
