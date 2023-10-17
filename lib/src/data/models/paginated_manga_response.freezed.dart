// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_manga_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaginatedMangaResponse _$PaginatedMangaResponseFromJson(
    Map<String, dynamic> json) {
  return _PaginatedMangaResponse.fromJson(json);
}

/// @nodoc
mixin _$PaginatedMangaResponse {
  List<MangaInfo> get data => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  int get maxCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaginatedMangaResponseCopyWith<PaginatedMangaResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedMangaResponseCopyWith<$Res> {
  factory $PaginatedMangaResponseCopyWith(PaginatedMangaResponse value,
          $Res Function(PaginatedMangaResponse) then) =
      _$PaginatedMangaResponseCopyWithImpl<$Res, PaginatedMangaResponse>;
  @useResult
  $Res call({List<MangaInfo> data, int currentPage, int maxCount});
}

/// @nodoc
class _$PaginatedMangaResponseCopyWithImpl<$Res,
        $Val extends PaginatedMangaResponse>
    implements $PaginatedMangaResponseCopyWith<$Res> {
  _$PaginatedMangaResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? currentPage = null,
    Object? maxCount = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<MangaInfo>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      maxCount: null == maxCount
          ? _value.maxCount
          : maxCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaginatedMangaResponseImplCopyWith<$Res>
    implements $PaginatedMangaResponseCopyWith<$Res> {
  factory _$$PaginatedMangaResponseImplCopyWith(
          _$PaginatedMangaResponseImpl value,
          $Res Function(_$PaginatedMangaResponseImpl) then) =
      __$$PaginatedMangaResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<MangaInfo> data, int currentPage, int maxCount});
}

/// @nodoc
class __$$PaginatedMangaResponseImplCopyWithImpl<$Res>
    extends _$PaginatedMangaResponseCopyWithImpl<$Res,
        _$PaginatedMangaResponseImpl>
    implements _$$PaginatedMangaResponseImplCopyWith<$Res> {
  __$$PaginatedMangaResponseImplCopyWithImpl(
      _$PaginatedMangaResponseImpl _value,
      $Res Function(_$PaginatedMangaResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? currentPage = null,
    Object? maxCount = null,
  }) {
    return _then(_$PaginatedMangaResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<MangaInfo>,
      currentPage: null == currentPage
          ? _value.currentPage
          : currentPage // ignore: cast_nullable_to_non_nullable
              as int,
      maxCount: null == maxCount
          ? _value.maxCount
          : maxCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedMangaResponseImpl implements _PaginatedMangaResponse {
  _$PaginatedMangaResponseImpl(
      {required final List<MangaInfo> data,
      required this.currentPage,
      required this.maxCount})
      : _data = data;

  factory _$PaginatedMangaResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedMangaResponseImplFromJson(json);

  final List<MangaInfo> _data;
  @override
  List<MangaInfo> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final int currentPage;
  @override
  final int maxCount;

  @override
  String toString() {
    return 'PaginatedMangaResponse(data: $data, currentPage: $currentPage, maxCount: $maxCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedMangaResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.maxCount, maxCount) ||
                other.maxCount == maxCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_data), currentPage, maxCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedMangaResponseImplCopyWith<_$PaginatedMangaResponseImpl>
      get copyWith => __$$PaginatedMangaResponseImplCopyWithImpl<
          _$PaginatedMangaResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedMangaResponseImplToJson(
      this,
    );
  }
}

abstract class _PaginatedMangaResponse implements PaginatedMangaResponse {
  factory _PaginatedMangaResponse(
      {required final List<MangaInfo> data,
      required final int currentPage,
      required final int maxCount}) = _$PaginatedMangaResponseImpl;

  factory _PaginatedMangaResponse.fromJson(Map<String, dynamic> json) =
      _$PaginatedMangaResponseImpl.fromJson;

  @override
  List<MangaInfo> get data;
  @override
  int get currentPage;
  @override
  int get maxCount;
  @override
  @JsonKey(ignore: true)
  _$$PaginatedMangaResponseImplCopyWith<_$PaginatedMangaResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
