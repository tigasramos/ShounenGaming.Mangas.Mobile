// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_release.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChapterRelease _$ChapterReleaseFromJson(Map<String, dynamic> json) {
  return _ChapterRelease.fromJson(json);
}

/// @nodoc
mixin _$ChapterRelease {
  int get id => throw _privateConstructorUsedError;
  num get name => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  TranslationLanguageEnum get translation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChapterReleaseCopyWith<ChapterRelease> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterReleaseCopyWith<$Res> {
  factory $ChapterReleaseCopyWith(
          ChapterRelease value, $Res Function(ChapterRelease) then) =
      _$ChapterReleaseCopyWithImpl<$Res, ChapterRelease>;
  @useResult
  $Res call(
      {int id,
      num name,
      DateTime createdAt,
      TranslationLanguageEnum translation});
}

/// @nodoc
class _$ChapterReleaseCopyWithImpl<$Res, $Val extends ChapterRelease>
    implements $ChapterReleaseCopyWith<$Res> {
  _$ChapterReleaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? translation = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as num,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as TranslationLanguageEnum,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChapterReleaseImplCopyWith<$Res>
    implements $ChapterReleaseCopyWith<$Res> {
  factory _$$ChapterReleaseImplCopyWith(_$ChapterReleaseImpl value,
          $Res Function(_$ChapterReleaseImpl) then) =
      __$$ChapterReleaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      num name,
      DateTime createdAt,
      TranslationLanguageEnum translation});
}

/// @nodoc
class __$$ChapterReleaseImplCopyWithImpl<$Res>
    extends _$ChapterReleaseCopyWithImpl<$Res, _$ChapterReleaseImpl>
    implements _$$ChapterReleaseImplCopyWith<$Res> {
  __$$ChapterReleaseImplCopyWithImpl(
      _$ChapterReleaseImpl _value, $Res Function(_$ChapterReleaseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? createdAt = null,
    Object? translation = null,
  }) {
    return _then(_$ChapterReleaseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as num,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      translation: null == translation
          ? _value.translation
          : translation // ignore: cast_nullable_to_non_nullable
              as TranslationLanguageEnum,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChapterReleaseImpl implements _ChapterRelease {
  _$ChapterReleaseImpl(
      {required this.id,
      required this.name,
      required this.createdAt,
      required this.translation});

  factory _$ChapterReleaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChapterReleaseImplFromJson(json);

  @override
  final int id;
  @override
  final num name;
  @override
  final DateTime createdAt;
  @override
  final TranslationLanguageEnum translation;

  @override
  String toString() {
    return 'ChapterRelease(id: $id, name: $name, createdAt: $createdAt, translation: $translation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChapterReleaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.translation, translation) ||
                other.translation == translation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, createdAt, translation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChapterReleaseImplCopyWith<_$ChapterReleaseImpl> get copyWith =>
      __$$ChapterReleaseImplCopyWithImpl<_$ChapterReleaseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChapterReleaseImplToJson(
      this,
    );
  }
}

abstract class _ChapterRelease implements ChapterRelease {
  factory _ChapterRelease(
          {required final int id,
          required final num name,
          required final DateTime createdAt,
          required final TranslationLanguageEnum translation}) =
      _$ChapterReleaseImpl;

  factory _ChapterRelease.fromJson(Map<String, dynamic> json) =
      _$ChapterReleaseImpl.fromJson;

  @override
  int get id;
  @override
  num get name;
  @override
  DateTime get createdAt;
  @override
  TranslationLanguageEnum get translation;
  @override
  @JsonKey(ignore: true)
  _$$ChapterReleaseImplCopyWith<_$ChapterReleaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
