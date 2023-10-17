// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MangaSource _$MangaSourceFromJson(Map<String, dynamic> json) {
  return _MangaSource.fromJson(json);
}

/// @nodoc
mixin _$MangaSource {
  String get name => throw _privateConstructorUsedError;
  MangaSourceEnum get source => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get imageURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaSourceCopyWith<MangaSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaSourceCopyWith<$Res> {
  factory $MangaSourceCopyWith(
          MangaSource value, $Res Function(MangaSource) then) =
      _$MangaSourceCopyWithImpl<$Res, MangaSource>;
  @useResult
  $Res call(
      {String name, MangaSourceEnum source, String url, String? imageURL});
}

/// @nodoc
class _$MangaSourceCopyWithImpl<$Res, $Val extends MangaSource>
    implements $MangaSourceCopyWith<$Res> {
  _$MangaSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? source = null,
    Object? url = null,
    Object? imageURL = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as MangaSourceEnum,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: freezed == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MangaSourceImplCopyWith<$Res>
    implements $MangaSourceCopyWith<$Res> {
  factory _$$MangaSourceImplCopyWith(
          _$MangaSourceImpl value, $Res Function(_$MangaSourceImpl) then) =
      __$$MangaSourceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, MangaSourceEnum source, String url, String? imageURL});
}

/// @nodoc
class __$$MangaSourceImplCopyWithImpl<$Res>
    extends _$MangaSourceCopyWithImpl<$Res, _$MangaSourceImpl>
    implements _$$MangaSourceImplCopyWith<$Res> {
  __$$MangaSourceImplCopyWithImpl(
      _$MangaSourceImpl _value, $Res Function(_$MangaSourceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? source = null,
    Object? url = null,
    Object? imageURL = freezed,
  }) {
    return _then(_$MangaSourceImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as MangaSourceEnum,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: freezed == imageURL
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaSourceImpl implements _MangaSource {
  _$MangaSourceImpl(
      {required this.name,
      required this.source,
      required this.url,
      this.imageURL});

  factory _$MangaSourceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaSourceImplFromJson(json);

  @override
  final String name;
  @override
  final MangaSourceEnum source;
  @override
  final String url;
  @override
  final String? imageURL;

  @override
  String toString() {
    return 'MangaSource(name: $name, source: $source, url: $url, imageURL: $imageURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaSourceImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.imageURL, imageURL) ||
                other.imageURL == imageURL));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, source, url, imageURL);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaSourceImplCopyWith<_$MangaSourceImpl> get copyWith =>
      __$$MangaSourceImplCopyWithImpl<_$MangaSourceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaSourceImplToJson(
      this,
    );
  }
}

abstract class _MangaSource implements MangaSource {
  factory _MangaSource(
      {required final String name,
      required final MangaSourceEnum source,
      required final String url,
      final String? imageURL}) = _$MangaSourceImpl;

  factory _MangaSource.fromJson(Map<String, dynamic> json) =
      _$MangaSourceImpl.fromJson;

  @override
  String get name;
  @override
  MangaSourceEnum get source;
  @override
  String get url;
  @override
  String? get imageURL;
  @override
  @JsonKey(ignore: true)
  _$$MangaSourceImplCopyWith<_$MangaSourceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
