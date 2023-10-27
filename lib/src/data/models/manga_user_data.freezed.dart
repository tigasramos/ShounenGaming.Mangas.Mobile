// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MangaUserData _$MangaUserDataFromJson(Map<String, dynamic> json) {
  return _MangaUserData.fromJson(json);
}

/// @nodoc
mixin _$MangaUserData {
  int get userId => throw _privateConstructorUsedError;
  MangaInfo get manga => throw _privateConstructorUsedError;
  MangaUserStatusEnum? get status => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  int get filteredReadChapters => throw _privateConstructorUsedError;
  int get filteredTotalChapters => throw _privateConstructorUsedError;
  DateTime? get addedToStatusDate => throw _privateConstructorUsedError;
  DateTime? get startedReadingDate => throw _privateConstructorUsedError;
  DateTime? get finishedReadingDate => throw _privateConstructorUsedError;
  List<int> get chaptersRead => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaUserDataCopyWith<MangaUserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaUserDataCopyWith<$Res> {
  factory $MangaUserDataCopyWith(
          MangaUserData value, $Res Function(MangaUserData) then) =
      _$MangaUserDataCopyWithImpl<$Res, MangaUserData>;
  @useResult
  $Res call(
      {int userId,
      MangaInfo manga,
      MangaUserStatusEnum? status,
      double? rating,
      int filteredReadChapters,
      int filteredTotalChapters,
      DateTime? addedToStatusDate,
      DateTime? startedReadingDate,
      DateTime? finishedReadingDate,
      List<int> chaptersRead});

  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class _$MangaUserDataCopyWithImpl<$Res, $Val extends MangaUserData>
    implements $MangaUserDataCopyWith<$Res> {
  _$MangaUserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? manga = null,
    Object? status = freezed,
    Object? rating = freezed,
    Object? filteredReadChapters = null,
    Object? filteredTotalChapters = null,
    Object? addedToStatusDate = freezed,
    Object? startedReadingDate = freezed,
    Object? finishedReadingDate = freezed,
    Object? chaptersRead = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MangaUserStatusEnum?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      filteredReadChapters: null == filteredReadChapters
          ? _value.filteredReadChapters
          : filteredReadChapters // ignore: cast_nullable_to_non_nullable
              as int,
      filteredTotalChapters: null == filteredTotalChapters
          ? _value.filteredTotalChapters
          : filteredTotalChapters // ignore: cast_nullable_to_non_nullable
              as int,
      addedToStatusDate: freezed == addedToStatusDate
          ? _value.addedToStatusDate
          : addedToStatusDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedReadingDate: freezed == startedReadingDate
          ? _value.startedReadingDate
          : startedReadingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedReadingDate: freezed == finishedReadingDate
          ? _value.finishedReadingDate
          : finishedReadingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chaptersRead: null == chaptersRead
          ? _value.chaptersRead
          : chaptersRead // ignore: cast_nullable_to_non_nullable
              as List<int>,
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
abstract class _$$MangaUserDataImplCopyWith<$Res>
    implements $MangaUserDataCopyWith<$Res> {
  factory _$$MangaUserDataImplCopyWith(
          _$MangaUserDataImpl value, $Res Function(_$MangaUserDataImpl) then) =
      __$$MangaUserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int userId,
      MangaInfo manga,
      MangaUserStatusEnum? status,
      double? rating,
      int filteredReadChapters,
      int filteredTotalChapters,
      DateTime? addedToStatusDate,
      DateTime? startedReadingDate,
      DateTime? finishedReadingDate,
      List<int> chaptersRead});

  @override
  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class __$$MangaUserDataImplCopyWithImpl<$Res>
    extends _$MangaUserDataCopyWithImpl<$Res, _$MangaUserDataImpl>
    implements _$$MangaUserDataImplCopyWith<$Res> {
  __$$MangaUserDataImplCopyWithImpl(
      _$MangaUserDataImpl _value, $Res Function(_$MangaUserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? manga = null,
    Object? status = freezed,
    Object? rating = freezed,
    Object? filteredReadChapters = null,
    Object? filteredTotalChapters = null,
    Object? addedToStatusDate = freezed,
    Object? startedReadingDate = freezed,
    Object? finishedReadingDate = freezed,
    Object? chaptersRead = null,
  }) {
    return _then(_$MangaUserDataImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MangaUserStatusEnum?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      filteredReadChapters: null == filteredReadChapters
          ? _value.filteredReadChapters
          : filteredReadChapters // ignore: cast_nullable_to_non_nullable
              as int,
      filteredTotalChapters: null == filteredTotalChapters
          ? _value.filteredTotalChapters
          : filteredTotalChapters // ignore: cast_nullable_to_non_nullable
              as int,
      addedToStatusDate: freezed == addedToStatusDate
          ? _value.addedToStatusDate
          : addedToStatusDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedReadingDate: freezed == startedReadingDate
          ? _value.startedReadingDate
          : startedReadingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      finishedReadingDate: freezed == finishedReadingDate
          ? _value.finishedReadingDate
          : finishedReadingDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      chaptersRead: null == chaptersRead
          ? _value._chaptersRead
          : chaptersRead // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaUserDataImpl implements _MangaUserData {
  _$MangaUserDataImpl(
      {required this.userId,
      required this.manga,
      this.status,
      this.rating,
      required this.filteredReadChapters,
      required this.filteredTotalChapters,
      this.addedToStatusDate,
      this.startedReadingDate,
      this.finishedReadingDate,
      required final List<int> chaptersRead})
      : _chaptersRead = chaptersRead;

  factory _$MangaUserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaUserDataImplFromJson(json);

  @override
  final int userId;
  @override
  final MangaInfo manga;
  @override
  final MangaUserStatusEnum? status;
  @override
  final double? rating;
  @override
  final int filteredReadChapters;
  @override
  final int filteredTotalChapters;
  @override
  final DateTime? addedToStatusDate;
  @override
  final DateTime? startedReadingDate;
  @override
  final DateTime? finishedReadingDate;
  final List<int> _chaptersRead;
  @override
  List<int> get chaptersRead {
    if (_chaptersRead is EqualUnmodifiableListView) return _chaptersRead;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chaptersRead);
  }

  @override
  String toString() {
    return 'MangaUserData(userId: $userId, manga: $manga, status: $status, rating: $rating, filteredReadChapters: $filteredReadChapters, filteredTotalChapters: $filteredTotalChapters, addedToStatusDate: $addedToStatusDate, startedReadingDate: $startedReadingDate, finishedReadingDate: $finishedReadingDate, chaptersRead: $chaptersRead)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaUserDataImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.manga, manga) || other.manga == manga) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.filteredReadChapters, filteredReadChapters) ||
                other.filteredReadChapters == filteredReadChapters) &&
            (identical(other.filteredTotalChapters, filteredTotalChapters) ||
                other.filteredTotalChapters == filteredTotalChapters) &&
            (identical(other.addedToStatusDate, addedToStatusDate) ||
                other.addedToStatusDate == addedToStatusDate) &&
            (identical(other.startedReadingDate, startedReadingDate) ||
                other.startedReadingDate == startedReadingDate) &&
            (identical(other.finishedReadingDate, finishedReadingDate) ||
                other.finishedReadingDate == finishedReadingDate) &&
            const DeepCollectionEquality()
                .equals(other._chaptersRead, _chaptersRead));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      manga,
      status,
      rating,
      filteredReadChapters,
      filteredTotalChapters,
      addedToStatusDate,
      startedReadingDate,
      finishedReadingDate,
      const DeepCollectionEquality().hash(_chaptersRead));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaUserDataImplCopyWith<_$MangaUserDataImpl> get copyWith =>
      __$$MangaUserDataImplCopyWithImpl<_$MangaUserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaUserDataImplToJson(
      this,
    );
  }
}

abstract class _MangaUserData implements MangaUserData {
  factory _MangaUserData(
      {required final int userId,
      required final MangaInfo manga,
      final MangaUserStatusEnum? status,
      final double? rating,
      required final int filteredReadChapters,
      required final int filteredTotalChapters,
      final DateTime? addedToStatusDate,
      final DateTime? startedReadingDate,
      final DateTime? finishedReadingDate,
      required final List<int> chaptersRead}) = _$MangaUserDataImpl;

  factory _MangaUserData.fromJson(Map<String, dynamic> json) =
      _$MangaUserDataImpl.fromJson;

  @override
  int get userId;
  @override
  MangaInfo get manga;
  @override
  MangaUserStatusEnum? get status;
  @override
  double? get rating;
  @override
  int get filteredReadChapters;
  @override
  int get filteredTotalChapters;
  @override
  DateTime? get addedToStatusDate;
  @override
  DateTime? get startedReadingDate;
  @override
  DateTime? get finishedReadingDate;
  @override
  List<int> get chaptersRead;
  @override
  @JsonKey(ignore: true)
  _$$MangaUserDataImplCopyWith<_$MangaUserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
