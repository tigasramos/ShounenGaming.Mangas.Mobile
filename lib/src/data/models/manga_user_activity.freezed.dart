// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_user_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MangaUserActivity _$MangaUserActivityFromJson(Map<String, dynamic> json) {
  return _MangaUserActivity.fromJson(json);
}

/// @nodoc
mixin _$MangaUserActivity {
  SimpleUser get user => throw _privateConstructorUsedError;
  MangaInfo get manga => throw _privateConstructorUsedError;
  DateTime get madeAt => throw _privateConstructorUsedError;
  UserActivityTypeEnum get activityType => throw _privateConstructorUsedError;
  double? get firstChapterRead => throw _privateConstructorUsedError;
  double? get lastChapterRead => throw _privateConstructorUsedError;
  MangaUserStatusEnum? get previousState => throw _privateConstructorUsedError;
  MangaUserStatusEnum? get newState => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaUserActivityCopyWith<MangaUserActivity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaUserActivityCopyWith<$Res> {
  factory $MangaUserActivityCopyWith(
          MangaUserActivity value, $Res Function(MangaUserActivity) then) =
      _$MangaUserActivityCopyWithImpl<$Res, MangaUserActivity>;
  @useResult
  $Res call(
      {SimpleUser user,
      MangaInfo manga,
      DateTime madeAt,
      UserActivityTypeEnum activityType,
      double? firstChapterRead,
      double? lastChapterRead,
      MangaUserStatusEnum? previousState,
      MangaUserStatusEnum? newState});

  $SimpleUserCopyWith<$Res> get user;
  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class _$MangaUserActivityCopyWithImpl<$Res, $Val extends MangaUserActivity>
    implements $MangaUserActivityCopyWith<$Res> {
  _$MangaUserActivityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? manga = null,
    Object? madeAt = null,
    Object? activityType = null,
    Object? firstChapterRead = freezed,
    Object? lastChapterRead = freezed,
    Object? previousState = freezed,
    Object? newState = freezed,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as SimpleUser,
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      madeAt: null == madeAt
          ? _value.madeAt
          : madeAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as UserActivityTypeEnum,
      firstChapterRead: freezed == firstChapterRead
          ? _value.firstChapterRead
          : firstChapterRead // ignore: cast_nullable_to_non_nullable
              as double?,
      lastChapterRead: freezed == lastChapterRead
          ? _value.lastChapterRead
          : lastChapterRead // ignore: cast_nullable_to_non_nullable
              as double?,
      previousState: freezed == previousState
          ? _value.previousState
          : previousState // ignore: cast_nullable_to_non_nullable
              as MangaUserStatusEnum?,
      newState: freezed == newState
          ? _value.newState
          : newState // ignore: cast_nullable_to_non_nullable
              as MangaUserStatusEnum?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SimpleUserCopyWith<$Res> get user {
    return $SimpleUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
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
abstract class _$$MangaUserActivityImplCopyWith<$Res>
    implements $MangaUserActivityCopyWith<$Res> {
  factory _$$MangaUserActivityImplCopyWith(_$MangaUserActivityImpl value,
          $Res Function(_$MangaUserActivityImpl) then) =
      __$$MangaUserActivityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SimpleUser user,
      MangaInfo manga,
      DateTime madeAt,
      UserActivityTypeEnum activityType,
      double? firstChapterRead,
      double? lastChapterRead,
      MangaUserStatusEnum? previousState,
      MangaUserStatusEnum? newState});

  @override
  $SimpleUserCopyWith<$Res> get user;
  @override
  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class __$$MangaUserActivityImplCopyWithImpl<$Res>
    extends _$MangaUserActivityCopyWithImpl<$Res, _$MangaUserActivityImpl>
    implements _$$MangaUserActivityImplCopyWith<$Res> {
  __$$MangaUserActivityImplCopyWithImpl(_$MangaUserActivityImpl _value,
      $Res Function(_$MangaUserActivityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? manga = null,
    Object? madeAt = null,
    Object? activityType = null,
    Object? firstChapterRead = freezed,
    Object? lastChapterRead = freezed,
    Object? previousState = freezed,
    Object? newState = freezed,
  }) {
    return _then(_$MangaUserActivityImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as SimpleUser,
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      madeAt: null == madeAt
          ? _value.madeAt
          : madeAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      activityType: null == activityType
          ? _value.activityType
          : activityType // ignore: cast_nullable_to_non_nullable
              as UserActivityTypeEnum,
      firstChapterRead: freezed == firstChapterRead
          ? _value.firstChapterRead
          : firstChapterRead // ignore: cast_nullable_to_non_nullable
              as double?,
      lastChapterRead: freezed == lastChapterRead
          ? _value.lastChapterRead
          : lastChapterRead // ignore: cast_nullable_to_non_nullable
              as double?,
      previousState: freezed == previousState
          ? _value.previousState
          : previousState // ignore: cast_nullable_to_non_nullable
              as MangaUserStatusEnum?,
      newState: freezed == newState
          ? _value.newState
          : newState // ignore: cast_nullable_to_non_nullable
              as MangaUserStatusEnum?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaUserActivityImpl implements _MangaUserActivity {
  _$MangaUserActivityImpl(
      {required this.user,
      required this.manga,
      required this.madeAt,
      required this.activityType,
      this.firstChapterRead,
      this.lastChapterRead,
      this.previousState,
      this.newState});

  factory _$MangaUserActivityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaUserActivityImplFromJson(json);

  @override
  final SimpleUser user;
  @override
  final MangaInfo manga;
  @override
  final DateTime madeAt;
  @override
  final UserActivityTypeEnum activityType;
  @override
  final double? firstChapterRead;
  @override
  final double? lastChapterRead;
  @override
  final MangaUserStatusEnum? previousState;
  @override
  final MangaUserStatusEnum? newState;

  @override
  String toString() {
    return 'MangaUserActivity(user: $user, manga: $manga, madeAt: $madeAt, activityType: $activityType, firstChapterRead: $firstChapterRead, lastChapterRead: $lastChapterRead, previousState: $previousState, newState: $newState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaUserActivityImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.manga, manga) || other.manga == manga) &&
            (identical(other.madeAt, madeAt) || other.madeAt == madeAt) &&
            (identical(other.activityType, activityType) ||
                other.activityType == activityType) &&
            (identical(other.firstChapterRead, firstChapterRead) ||
                other.firstChapterRead == firstChapterRead) &&
            (identical(other.lastChapterRead, lastChapterRead) ||
                other.lastChapterRead == lastChapterRead) &&
            (identical(other.previousState, previousState) ||
                other.previousState == previousState) &&
            (identical(other.newState, newState) ||
                other.newState == newState));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user, manga, madeAt,
      activityType, firstChapterRead, lastChapterRead, previousState, newState);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaUserActivityImplCopyWith<_$MangaUserActivityImpl> get copyWith =>
      __$$MangaUserActivityImplCopyWithImpl<_$MangaUserActivityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaUserActivityImplToJson(
      this,
    );
  }
}

abstract class _MangaUserActivity implements MangaUserActivity {
  factory _MangaUserActivity(
      {required final SimpleUser user,
      required final MangaInfo manga,
      required final DateTime madeAt,
      required final UserActivityTypeEnum activityType,
      final double? firstChapterRead,
      final double? lastChapterRead,
      final MangaUserStatusEnum? previousState,
      final MangaUserStatusEnum? newState}) = _$MangaUserActivityImpl;

  factory _MangaUserActivity.fromJson(Map<String, dynamic> json) =
      _$MangaUserActivityImpl.fromJson;

  @override
  SimpleUser get user;
  @override
  MangaInfo get manga;
  @override
  DateTime get madeAt;
  @override
  UserActivityTypeEnum get activityType;
  @override
  double? get firstChapterRead;
  @override
  double? get lastChapterRead;
  @override
  MangaUserStatusEnum? get previousState;
  @override
  MangaUserStatusEnum? get newState;
  @override
  @JsonKey(ignore: true)
  _$$MangaUserActivityImplCopyWith<_$MangaUserActivityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
