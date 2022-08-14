// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'mute_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MutePost _$MutePostFromJson(Map<String, dynamic> json) {
  return _MutePost.fromJson(json);
}

/// @nodoc
mixin _$MutePost {
  String get activeUid => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  String get tokenId => throw _privateConstructorUsedError;
  String get tokenType => throw _privateConstructorUsedError;
  String get passiveUid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MutePostCopyWith<MutePost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MutePostCopyWith<$Res> {
  factory $MutePostCopyWith(MutePost value, $Res Function(MutePost) then) =
      _$MutePostCopyWithImpl<$Res>;
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postId,
      String tokenId,
      String tokenType,
      String passiveUid});
}

/// @nodoc
class _$MutePostCopyWithImpl<$Res> implements $MutePostCopyWith<$Res> {
  _$MutePostCopyWithImpl(this._value, this._then);

  final MutePost _value;
  // ignore: unused_field
  final $Res Function(MutePost) _then;

  @override
  $Res call({
    Object? activeUid = freezed,
    Object? createdAt = freezed,
    Object? postId = freezed,
    Object? tokenId = freezed,
    Object? tokenType = freezed,
    Object? passiveUid = freezed,
  }) {
    return _then(_value.copyWith(
      activeUid: activeUid == freezed
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: tokenId == freezed
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: tokenType == freezed
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      passiveUid: passiveUid == freezed
          ? _value.passiveUid
          : passiveUid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MutePostCopyWith<$Res> implements $MutePostCopyWith<$Res> {
  factory _$$_MutePostCopyWith(
          _$_MutePost value, $Res Function(_$_MutePost) then) =
      __$$_MutePostCopyWithImpl<$Res>;
  @override
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postId,
      String tokenId,
      String tokenType,
      String passiveUid});
}

/// @nodoc
class __$$_MutePostCopyWithImpl<$Res> extends _$MutePostCopyWithImpl<$Res>
    implements _$$_MutePostCopyWith<$Res> {
  __$$_MutePostCopyWithImpl(
      _$_MutePost _value, $Res Function(_$_MutePost) _then)
      : super(_value, (v) => _then(v as _$_MutePost));

  @override
  _$_MutePost get _value => super._value as _$_MutePost;

  @override
  $Res call({
    Object? activeUid = freezed,
    Object? createdAt = freezed,
    Object? postId = freezed,
    Object? tokenId = freezed,
    Object? tokenType = freezed,
    Object? passiveUid = freezed,
  }) {
    return _then(_$_MutePost(
      activeUid: activeUid == freezed
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: postId == freezed
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: tokenId == freezed
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: tokenType == freezed
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
      passiveUid: passiveUid == freezed
          ? _value.passiveUid
          : passiveUid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MutePost implements _MutePost {
  const _$_MutePost(
      {required this.activeUid,
      required this.createdAt,
      required this.postId,
      required this.tokenId,
      required this.tokenType,
      required this.passiveUid});

  factory _$_MutePost.fromJson(Map<String, dynamic> json) =>
      _$$_MutePostFromJson(json);

  @override
  final String activeUid;
  @override
  final dynamic createdAt;
  @override
  final String postId;
  @override
  final String tokenId;
  @override
  final String tokenType;
  @override
  final String passiveUid;

  @override
  String toString() {
    return 'MutePost(activeUid: $activeUid, createdAt: $createdAt, postId: $postId, tokenId: $tokenId, tokenType: $tokenType, passiveUid: $passiveUid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MutePost &&
            const DeepCollectionEquality().equals(other.activeUid, activeUid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.postId, postId) &&
            const DeepCollectionEquality().equals(other.tokenId, tokenId) &&
            const DeepCollectionEquality().equals(other.tokenType, tokenType) &&
            const DeepCollectionEquality()
                .equals(other.passiveUid, passiveUid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(activeUid),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(postId),
      const DeepCollectionEquality().hash(tokenId),
      const DeepCollectionEquality().hash(tokenType),
      const DeepCollectionEquality().hash(passiveUid));

  @JsonKey(ignore: true)
  @override
  _$$_MutePostCopyWith<_$_MutePost> get copyWith =>
      __$$_MutePostCopyWithImpl<_$_MutePost>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MutePostToJson(
      this,
    );
  }
}

abstract class _MutePost implements MutePost {
  const factory _MutePost(
      {required final String activeUid,
      required final dynamic createdAt,
      required final String postId,
      required final String tokenId,
      required final String tokenType,
      required final String passiveUid}) = _$_MutePost;

  factory _MutePost.fromJson(Map<String, dynamic> json) = _$_MutePost.fromJson;

  @override
  String get activeUid;
  @override
  dynamic get createdAt;
  @override
  String get postId;
  @override
  String get tokenId;
  @override
  String get tokenType;
  @override
  String get passiveUid;
  @override
  @JsonKey(ignore: true)
  _$$_MutePostCopyWith<_$_MutePost> get copyWith =>
      throw _privateConstructorUsedError;
}
