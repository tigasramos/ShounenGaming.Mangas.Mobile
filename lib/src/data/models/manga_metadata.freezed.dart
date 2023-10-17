// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MangaMetadata _$MangaMetadataFromJson(Map<String, dynamic> json) {
  return _MangaMetadata.fromJson(json);
}

/// @nodoc
mixin _$MangaMetadata {
  int get id => throw _privateConstructorUsedError;
  MangaMetadataSourceEnum get source => throw _privateConstructorUsedError;
  List<String> get titles => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  bool get alreadyExists => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  num? get score => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get finishedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaMetadataCopyWith<MangaMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaMetadataCopyWith<$Res> {
  factory $MangaMetadataCopyWith(
          MangaMetadata value, $Res Function(MangaMetadata) then) =
      _$MangaMetadataCopyWithImpl<$Res, MangaMetadata>;
  @useResult
  $Res call(
      {int id,
      MangaMetadataSourceEnum source,
      List<String> titles,
      String imageUrl,
      bool alreadyExists,
      String type,
      String description,
      String status,
      num? score,
      List<String> tags,
      DateTime? startedAt,
      DateTime? finishedAt});
}

/// @nodoc
class _$MangaMetadataCopyWithImpl<$Res, $Val extends MangaMetadata>
    implements $MangaMetadataCopyWith<$Res> {
  _$MangaMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? source = null,
    Object? titles = null,
    Object? imageUrl = null,
    Object? alreadyExists = null,
    Object? type = null,
    Object? description = null,
    Object? status = null,
    Object? score = freezed,
    Object? tags = null,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as MangaMetadataSourceEnum,
      titles: null == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      alreadyExists: null == alreadyExists
          ? _value.alreadyExists
          : alreadyExists // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as num?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
}

/// @nodoc
abstract class _$$MangaMetadataImplCopyWith<$Res>
    implements $MangaMetadataCopyWith<$Res> {
  factory _$$MangaMetadataImplCopyWith(
          _$MangaMetadataImpl value, $Res Function(_$MangaMetadataImpl) then) =
      __$$MangaMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      MangaMetadataSourceEnum source,
      List<String> titles,
      String imageUrl,
      bool alreadyExists,
      String type,
      String description,
      String status,
      num? score,
      List<String> tags,
      DateTime? startedAt,
      DateTime? finishedAt});
}

/// @nodoc
class __$$MangaMetadataImplCopyWithImpl<$Res>
    extends _$MangaMetadataCopyWithImpl<$Res, _$MangaMetadataImpl>
    implements _$$MangaMetadataImplCopyWith<$Res> {
  __$$MangaMetadataImplCopyWithImpl(
      _$MangaMetadataImpl _value, $Res Function(_$MangaMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? source = null,
    Object? titles = null,
    Object? imageUrl = null,
    Object? alreadyExists = null,
    Object? type = null,
    Object? description = null,
    Object? status = null,
    Object? score = freezed,
    Object? tags = null,
    Object? startedAt = freezed,
    Object? finishedAt = freezed,
  }) {
    return _then(_$MangaMetadataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as MangaMetadataSourceEnum,
      titles: null == titles
          ? _value._titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      alreadyExists: null == alreadyExists
          ? _value.alreadyExists
          : alreadyExists // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as num?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
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
class _$MangaMetadataImpl implements _MangaMetadata {
  _$MangaMetadataImpl(
      {required this.id,
      required this.source,
      required final List<String> titles,
      required this.imageUrl,
      required this.alreadyExists,
      required this.type,
      required this.description,
      required this.status,
      this.score,
      required final List<String> tags,
      this.startedAt,
      this.finishedAt})
      : _titles = titles,
        _tags = tags;

  factory _$MangaMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaMetadataImplFromJson(json);

  @override
  final int id;
  @override
  final MangaMetadataSourceEnum source;
  final List<String> _titles;
  @override
  List<String> get titles {
    if (_titles is EqualUnmodifiableListView) return _titles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_titles);
  }

  @override
  final String imageUrl;
  @override
  final bool alreadyExists;
  @override
  final String type;
  @override
  final String description;
  @override
  final String status;
  @override
  final num? score;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? startedAt;
  @override
  final DateTime? finishedAt;

  @override
  String toString() {
    return 'MangaMetadata(id: $id, source: $source, titles: $titles, imageUrl: $imageUrl, alreadyExists: $alreadyExists, type: $type, description: $description, status: $status, score: $score, tags: $tags, startedAt: $startedAt, finishedAt: $finishedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaMetadataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.source, source) || other.source == source) &&
            const DeepCollectionEquality().equals(other._titles, _titles) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.alreadyExists, alreadyExists) ||
                other.alreadyExists == alreadyExists) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.finishedAt, finishedAt) ||
                other.finishedAt == finishedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      source,
      const DeepCollectionEquality().hash(_titles),
      imageUrl,
      alreadyExists,
      type,
      description,
      status,
      score,
      const DeepCollectionEquality().hash(_tags),
      startedAt,
      finishedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaMetadataImplCopyWith<_$MangaMetadataImpl> get copyWith =>
      __$$MangaMetadataImplCopyWithImpl<_$MangaMetadataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaMetadataImplToJson(
      this,
    );
  }
}

abstract class _MangaMetadata implements MangaMetadata {
  factory _MangaMetadata(
      {required final int id,
      required final MangaMetadataSourceEnum source,
      required final List<String> titles,
      required final String imageUrl,
      required final bool alreadyExists,
      required final String type,
      required final String description,
      required final String status,
      final num? score,
      required final List<String> tags,
      final DateTime? startedAt,
      final DateTime? finishedAt}) = _$MangaMetadataImpl;

  factory _MangaMetadata.fromJson(Map<String, dynamic> json) =
      _$MangaMetadataImpl.fromJson;

  @override
  int get id;
  @override
  MangaMetadataSourceEnum get source;
  @override
  List<String> get titles;
  @override
  String get imageUrl;
  @override
  bool get alreadyExists;
  @override
  String get type;
  @override
  String get description;
  @override
  String get status;
  @override
  num? get score;
  @override
  List<String> get tags;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get finishedAt;
  @override
  @JsonKey(ignore: true)
  _$$MangaMetadataImplCopyWith<_$MangaMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
