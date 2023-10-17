// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_translation_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MangaTranslationInfo _$MangaTranslationInfoFromJson(Map<String, dynamic> json) {
  return _MangaTranslationInfo.fromJson(json);
}

/// @nodoc
mixin _$MangaTranslationInfo {
  int get id => throw _privateConstructorUsedError;
  TranslationLanguageEnum get language => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaTranslationInfoCopyWith<MangaTranslationInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaTranslationInfoCopyWith<$Res> {
  factory $MangaTranslationInfoCopyWith(MangaTranslationInfo value,
          $Res Function(MangaTranslationInfo) then) =
      _$MangaTranslationInfoCopyWithImpl<$Res, MangaTranslationInfo>;
  @useResult
  $Res call({int id, TranslationLanguageEnum language, DateTime createdAt});
}

/// @nodoc
class _$MangaTranslationInfoCopyWithImpl<$Res,
        $Val extends MangaTranslationInfo>
    implements $MangaTranslationInfoCopyWith<$Res> {
  _$MangaTranslationInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? language = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as TranslationLanguageEnum,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MangaTranslationInfoImplCopyWith<$Res>
    implements $MangaTranslationInfoCopyWith<$Res> {
  factory _$$MangaTranslationInfoImplCopyWith(_$MangaTranslationInfoImpl value,
          $Res Function(_$MangaTranslationInfoImpl) then) =
      __$$MangaTranslationInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, TranslationLanguageEnum language, DateTime createdAt});
}

/// @nodoc
class __$$MangaTranslationInfoImplCopyWithImpl<$Res>
    extends _$MangaTranslationInfoCopyWithImpl<$Res, _$MangaTranslationInfoImpl>
    implements _$$MangaTranslationInfoImplCopyWith<$Res> {
  __$$MangaTranslationInfoImplCopyWithImpl(_$MangaTranslationInfoImpl _value,
      $Res Function(_$MangaTranslationInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? language = null,
    Object? createdAt = null,
  }) {
    return _then(_$MangaTranslationInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as TranslationLanguageEnum,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaTranslationInfoImpl implements _MangaTranslationInfo {
  _$MangaTranslationInfoImpl(
      {required this.id, required this.language, required this.createdAt});

  factory _$MangaTranslationInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaTranslationInfoImplFromJson(json);

  @override
  final int id;
  @override
  final TranslationLanguageEnum language;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'MangaTranslationInfo(id: $id, language: $language, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaTranslationInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, language, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaTranslationInfoImplCopyWith<_$MangaTranslationInfoImpl>
      get copyWith =>
          __$$MangaTranslationInfoImplCopyWithImpl<_$MangaTranslationInfoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaTranslationInfoImplToJson(
      this,
    );
  }
}

abstract class _MangaTranslationInfo implements MangaTranslationInfo {
  factory _MangaTranslationInfo(
      {required final int id,
      required final TranslationLanguageEnum language,
      required final DateTime createdAt}) = _$MangaTranslationInfoImpl;

  factory _MangaTranslationInfo.fromJson(Map<String, dynamic> json) =
      _$MangaTranslationInfoImpl.fromJson;

  @override
  int get id;
  @override
  TranslationLanguageEnum get language;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$MangaTranslationInfoImplCopyWith<_$MangaTranslationInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
