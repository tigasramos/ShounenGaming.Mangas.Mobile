// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SimpleUser _$SimpleUserFromJson(Map<String, dynamic> json) {
  return _SimpleUser.fromJson(json);
}

/// @nodoc
mixin _$SimpleUser {
  int get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get discordImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SimpleUserCopyWith<SimpleUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleUserCopyWith<$Res> {
  factory $SimpleUserCopyWith(
          SimpleUser value, $Res Function(SimpleUser) then) =
      _$SimpleUserCopyWithImpl<$Res, SimpleUser>;
  @useResult
  $Res call({int id, String fullName, String username, String? discordImage});
}

/// @nodoc
class _$SimpleUserCopyWithImpl<$Res, $Val extends SimpleUser>
    implements $SimpleUserCopyWith<$Res> {
  _$SimpleUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? username = null,
    Object? discordImage = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      discordImage: freezed == discordImage
          ? _value.discordImage
          : discordImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SimpleUserImplCopyWith<$Res>
    implements $SimpleUserCopyWith<$Res> {
  factory _$$SimpleUserImplCopyWith(
          _$SimpleUserImpl value, $Res Function(_$SimpleUserImpl) then) =
      __$$SimpleUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String fullName, String username, String? discordImage});
}

/// @nodoc
class __$$SimpleUserImplCopyWithImpl<$Res>
    extends _$SimpleUserCopyWithImpl<$Res, _$SimpleUserImpl>
    implements _$$SimpleUserImplCopyWith<$Res> {
  __$$SimpleUserImplCopyWithImpl(
      _$SimpleUserImpl _value, $Res Function(_$SimpleUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? username = null,
    Object? discordImage = freezed,
  }) {
    return _then(_$SimpleUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      discordImage: freezed == discordImage
          ? _value.discordImage
          : discordImage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SimpleUserImpl implements _SimpleUser {
  _$SimpleUserImpl(
      {required this.id,
      required this.fullName,
      required this.username,
      this.discordImage});

  factory _$SimpleUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimpleUserImplFromJson(json);

  @override
  final int id;
  @override
  final String fullName;
  @override
  final String username;
  @override
  final String? discordImage;

  @override
  String toString() {
    return 'SimpleUser(id: $id, fullName: $fullName, username: $username, discordImage: $discordImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimpleUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.discordImage, discordImage) ||
                other.discordImage == discordImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, fullName, username, discordImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SimpleUserImplCopyWith<_$SimpleUserImpl> get copyWith =>
      __$$SimpleUserImplCopyWithImpl<_$SimpleUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SimpleUserImplToJson(
      this,
    );
  }
}

abstract class _SimpleUser implements SimpleUser {
  factory _SimpleUser(
      {required final int id,
      required final String fullName,
      required final String username,
      final String? discordImage}) = _$SimpleUserImpl;

  factory _SimpleUser.fromJson(Map<String, dynamic> json) =
      _$SimpleUserImpl.fromJson;

  @override
  int get id;
  @override
  String get fullName;
  @override
  String get username;
  @override
  String? get discordImage;
  @override
  @JsonKey(ignore: true)
  _$$SimpleUserImplCopyWith<_$SimpleUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
