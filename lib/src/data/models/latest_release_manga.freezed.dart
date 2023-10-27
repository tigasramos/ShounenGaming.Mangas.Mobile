// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latest_release_manga.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LatestReleaseManga _$LatestReleaseMangaFromJson(Map<String, dynamic> json) {
  return _LatestReleaseManga.fromJson(json);
}

/// @nodoc
mixin _$LatestReleaseManga {
  MangaInfo get manga => throw _privateConstructorUsedError;
  Map<TranslationLanguageEnum, ChapterRelease> get releasedChapters =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LatestReleaseMangaCopyWith<LatestReleaseManga> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LatestReleaseMangaCopyWith<$Res> {
  factory $LatestReleaseMangaCopyWith(
          LatestReleaseManga value, $Res Function(LatestReleaseManga) then) =
      _$LatestReleaseMangaCopyWithImpl<$Res, LatestReleaseManga>;
  @useResult
  $Res call(
      {MangaInfo manga,
      Map<TranslationLanguageEnum, ChapterRelease> releasedChapters});

  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class _$LatestReleaseMangaCopyWithImpl<$Res, $Val extends LatestReleaseManga>
    implements $LatestReleaseMangaCopyWith<$Res> {
  _$LatestReleaseMangaCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manga = null,
    Object? releasedChapters = null,
  }) {
    return _then(_value.copyWith(
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      releasedChapters: null == releasedChapters
          ? _value.releasedChapters
          : releasedChapters // ignore: cast_nullable_to_non_nullable
              as Map<TranslationLanguageEnum, ChapterRelease>,
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
abstract class _$$LatestReleaseMangaImplCopyWith<$Res>
    implements $LatestReleaseMangaCopyWith<$Res> {
  factory _$$LatestReleaseMangaImplCopyWith(_$LatestReleaseMangaImpl value,
          $Res Function(_$LatestReleaseMangaImpl) then) =
      __$$LatestReleaseMangaImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MangaInfo manga,
      Map<TranslationLanguageEnum, ChapterRelease> releasedChapters});

  @override
  $MangaInfoCopyWith<$Res> get manga;
}

/// @nodoc
class __$$LatestReleaseMangaImplCopyWithImpl<$Res>
    extends _$LatestReleaseMangaCopyWithImpl<$Res, _$LatestReleaseMangaImpl>
    implements _$$LatestReleaseMangaImplCopyWith<$Res> {
  __$$LatestReleaseMangaImplCopyWithImpl(_$LatestReleaseMangaImpl _value,
      $Res Function(_$LatestReleaseMangaImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? manga = null,
    Object? releasedChapters = null,
  }) {
    return _then(_$LatestReleaseMangaImpl(
      manga: null == manga
          ? _value.manga
          : manga // ignore: cast_nullable_to_non_nullable
              as MangaInfo,
      releasedChapters: null == releasedChapters
          ? _value._releasedChapters
          : releasedChapters // ignore: cast_nullable_to_non_nullable
              as Map<TranslationLanguageEnum, ChapterRelease>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LatestReleaseMangaImpl implements _LatestReleaseManga {
  _$LatestReleaseMangaImpl(
      {required this.manga,
      required final Map<TranslationLanguageEnum, ChapterRelease>
          releasedChapters})
      : _releasedChapters = releasedChapters;

  factory _$LatestReleaseMangaImpl.fromJson(Map<String, dynamic> json) =>
      _$$LatestReleaseMangaImplFromJson(json);

  @override
  final MangaInfo manga;
  final Map<TranslationLanguageEnum, ChapterRelease> _releasedChapters;
  @override
  Map<TranslationLanguageEnum, ChapterRelease> get releasedChapters {
    if (_releasedChapters is EqualUnmodifiableMapView) return _releasedChapters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_releasedChapters);
  }

  @override
  String toString() {
    return 'LatestReleaseManga(manga: $manga, releasedChapters: $releasedChapters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LatestReleaseMangaImpl &&
            (identical(other.manga, manga) || other.manga == manga) &&
            const DeepCollectionEquality()
                .equals(other._releasedChapters, _releasedChapters));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, manga,
      const DeepCollectionEquality().hash(_releasedChapters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LatestReleaseMangaImplCopyWith<_$LatestReleaseMangaImpl> get copyWith =>
      __$$LatestReleaseMangaImplCopyWithImpl<_$LatestReleaseMangaImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LatestReleaseMangaImplToJson(
      this,
    );
  }
}

abstract class _LatestReleaseManga implements LatestReleaseManga {
  factory _LatestReleaseManga(
      {required final MangaInfo manga,
      required final Map<TranslationLanguageEnum, ChapterRelease>
          releasedChapters}) = _$LatestReleaseMangaImpl;

  factory _LatestReleaseManga.fromJson(Map<String, dynamic> json) =
      _$LatestReleaseMangaImpl.fromJson;

  @override
  MangaInfo get manga;
  @override
  Map<TranslationLanguageEnum, ChapterRelease> get releasedChapters;
  @override
  @JsonKey(ignore: true)
  _$$LatestReleaseMangaImplCopyWith<_$LatestReleaseMangaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
