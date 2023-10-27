// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'string_pair.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StringPair _$StringPairFromJson(Map<String, dynamic> json) {
  return _StringPair.fromJson(json);
}

/// @nodoc
mixin _$StringPair {
  String get id => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StringPairCopyWith<StringPair> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StringPairCopyWith<$Res> {
  factory $StringPairCopyWith(
          StringPair value, $Res Function(StringPair) then) =
      _$StringPairCopyWithImpl<$Res, StringPair>;
  @useResult
  $Res call({String id, String value});
}

/// @nodoc
class _$StringPairCopyWithImpl<$Res, $Val extends StringPair>
    implements $StringPairCopyWith<$Res> {
  _$StringPairCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StringPairImplCopyWith<$Res>
    implements $StringPairCopyWith<$Res> {
  factory _$$StringPairImplCopyWith(
          _$StringPairImpl value, $Res Function(_$StringPairImpl) then) =
      __$$StringPairImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String value});
}

/// @nodoc
class __$$StringPairImplCopyWithImpl<$Res>
    extends _$StringPairCopyWithImpl<$Res, _$StringPairImpl>
    implements _$$StringPairImplCopyWith<$Res> {
  __$$StringPairImplCopyWithImpl(
      _$StringPairImpl _value, $Res Function(_$StringPairImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? value = null,
  }) {
    return _then(_$StringPairImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StringPairImpl implements _StringPair {
  _$StringPairImpl({required this.id, required this.value});

  factory _$StringPairImpl.fromJson(Map<String, dynamic> json) =>
      _$$StringPairImplFromJson(json);

  @override
  final String id;
  @override
  final String value;

  @override
  String toString() {
    return 'StringPair(id: $id, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StringPairImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StringPairImplCopyWith<_$StringPairImpl> get copyWith =>
      __$$StringPairImplCopyWithImpl<_$StringPairImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StringPairImplToJson(
      this,
    );
  }
}

abstract class _StringPair implements StringPair {
  factory _StringPair({required final String id, required final String value}) =
      _$StringPairImpl;

  factory _StringPair.fromJson(Map<String, dynamic> json) =
      _$StringPairImpl.fromJson;

  @override
  String get id;
  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  _$$StringPairImplCopyWith<_$StringPairImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
