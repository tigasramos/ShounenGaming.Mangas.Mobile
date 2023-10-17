// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QueueProgress _$QueueProgressFromJson(Map<String, dynamic> json) {
  return _QueueProgress.fromJson(json);
}

/// @nodoc
mixin _$QueueProgress {
  double get percentage => throw _privateConstructorUsedError;
  MangaSourceEnum get currentSource => throw _privateConstructorUsedError;
  int get currentChapter => throw _privateConstructorUsedError;
  int get totalChapters => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QueueProgressCopyWith<QueueProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueProgressCopyWith<$Res> {
  factory $QueueProgressCopyWith(
          QueueProgress value, $Res Function(QueueProgress) then) =
      _$QueueProgressCopyWithImpl<$Res, QueueProgress>;
  @useResult
  $Res call(
      {double percentage,
      MangaSourceEnum currentSource,
      int currentChapter,
      int totalChapters});
}

/// @nodoc
class _$QueueProgressCopyWithImpl<$Res, $Val extends QueueProgress>
    implements $QueueProgressCopyWith<$Res> {
  _$QueueProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percentage = null,
    Object? currentSource = null,
    Object? currentChapter = null,
    Object? totalChapters = null,
  }) {
    return _then(_value.copyWith(
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      currentSource: null == currentSource
          ? _value.currentSource
          : currentSource // ignore: cast_nullable_to_non_nullable
              as MangaSourceEnum,
      currentChapter: null == currentChapter
          ? _value.currentChapter
          : currentChapter // ignore: cast_nullable_to_non_nullable
              as int,
      totalChapters: null == totalChapters
          ? _value.totalChapters
          : totalChapters // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueueProgressImplCopyWith<$Res>
    implements $QueueProgressCopyWith<$Res> {
  factory _$$QueueProgressImplCopyWith(
          _$QueueProgressImpl value, $Res Function(_$QueueProgressImpl) then) =
      __$$QueueProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double percentage,
      MangaSourceEnum currentSource,
      int currentChapter,
      int totalChapters});
}

/// @nodoc
class __$$QueueProgressImplCopyWithImpl<$Res>
    extends _$QueueProgressCopyWithImpl<$Res, _$QueueProgressImpl>
    implements _$$QueueProgressImplCopyWith<$Res> {
  __$$QueueProgressImplCopyWithImpl(
      _$QueueProgressImpl _value, $Res Function(_$QueueProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percentage = null,
    Object? currentSource = null,
    Object? currentChapter = null,
    Object? totalChapters = null,
  }) {
    return _then(_$QueueProgressImpl(
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      currentSource: null == currentSource
          ? _value.currentSource
          : currentSource // ignore: cast_nullable_to_non_nullable
              as MangaSourceEnum,
      currentChapter: null == currentChapter
          ? _value.currentChapter
          : currentChapter // ignore: cast_nullable_to_non_nullable
              as int,
      totalChapters: null == totalChapters
          ? _value.totalChapters
          : totalChapters // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueProgressImpl implements _QueueProgress {
  _$QueueProgressImpl(
      {required this.percentage,
      required this.currentSource,
      required this.currentChapter,
      required this.totalChapters});

  factory _$QueueProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueProgressImplFromJson(json);

  @override
  final double percentage;
  @override
  final MangaSourceEnum currentSource;
  @override
  final int currentChapter;
  @override
  final int totalChapters;

  @override
  String toString() {
    return 'QueueProgress(percentage: $percentage, currentSource: $currentSource, currentChapter: $currentChapter, totalChapters: $totalChapters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueProgressImpl &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.currentSource, currentSource) ||
                other.currentSource == currentSource) &&
            (identical(other.currentChapter, currentChapter) ||
                other.currentChapter == currentChapter) &&
            (identical(other.totalChapters, totalChapters) ||
                other.totalChapters == totalChapters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, percentage, currentSource, currentChapter, totalChapters);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueProgressImplCopyWith<_$QueueProgressImpl> get copyWith =>
      __$$QueueProgressImplCopyWithImpl<_$QueueProgressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueProgressImplToJson(
      this,
    );
  }
}

abstract class _QueueProgress implements QueueProgress {
  factory _QueueProgress(
      {required final double percentage,
      required final MangaSourceEnum currentSource,
      required final int currentChapter,
      required final int totalChapters}) = _$QueueProgressImpl;

  factory _QueueProgress.fromJson(Map<String, dynamic> json) =
      _$QueueProgressImpl.fromJson;

  @override
  double get percentage;
  @override
  MangaSourceEnum get currentSource;
  @override
  int get currentChapter;
  @override
  int get totalChapters;
  @override
  @JsonKey(ignore: true)
  _$$QueueProgressImplCopyWith<_$QueueProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
