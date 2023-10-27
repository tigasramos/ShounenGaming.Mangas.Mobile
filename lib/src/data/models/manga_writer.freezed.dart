// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manga_writer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MangaWriter _$MangaWriterFromJson(Map<String, dynamic> json) {
  return _MangaWriter.fromJson(json);
}

/// @nodoc
mixin _$MangaWriter {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MangaWriterCopyWith<MangaWriter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaWriterCopyWith<$Res> {
  factory $MangaWriterCopyWith(
          MangaWriter value, $Res Function(MangaWriter) then) =
      _$MangaWriterCopyWithImpl<$Res, MangaWriter>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$MangaWriterCopyWithImpl<$Res, $Val extends MangaWriter>
    implements $MangaWriterCopyWith<$Res> {
  _$MangaWriterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MangaWriterImplCopyWith<$Res>
    implements $MangaWriterCopyWith<$Res> {
  factory _$$MangaWriterImplCopyWith(
          _$MangaWriterImpl value, $Res Function(_$MangaWriterImpl) then) =
      __$$MangaWriterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$MangaWriterImplCopyWithImpl<$Res>
    extends _$MangaWriterCopyWithImpl<$Res, _$MangaWriterImpl>
    implements _$$MangaWriterImplCopyWith<$Res> {
  __$$MangaWriterImplCopyWithImpl(
      _$MangaWriterImpl _value, $Res Function(_$MangaWriterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$MangaWriterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MangaWriterImpl implements _MangaWriter {
  _$MangaWriterImpl({required this.id, required this.name});

  factory _$MangaWriterImpl.fromJson(Map<String, dynamic> json) =>
      _$$MangaWriterImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'MangaWriter(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaWriterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaWriterImplCopyWith<_$MangaWriterImpl> get copyWith =>
      __$$MangaWriterImplCopyWithImpl<_$MangaWriterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MangaWriterImplToJson(
      this,
    );
  }
}

abstract class _MangaWriter implements MangaWriter {
  factory _MangaWriter({required final int id, required final String name}) =
      _$MangaWriterImpl;

  factory _MangaWriter.fromJson(Map<String, dynamic> json) =
      _$MangaWriterImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$MangaWriterImplCopyWith<_$MangaWriterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
