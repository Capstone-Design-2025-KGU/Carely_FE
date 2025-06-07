// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_outline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostOutline _$PostOutlineFromJson(Map<String, dynamic> json) {
  return _PostOutline.fromJson(json);
}

/// @nodoc
mixin _$PostOutline {
  int get postId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get commentCount => throw _privateConstructorUsedError;
  Member get writer => throw _privateConstructorUsedError;

  /// Serializes this PostOutline to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostOutline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostOutlineCopyWith<PostOutline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostOutlineCopyWith<$Res> {
  factory $PostOutlineCopyWith(
    PostOutline value,
    $Res Function(PostOutline) then,
  ) = _$PostOutlineCopyWithImpl<$Res, PostOutline>;
  @useResult
  $Res call({int postId, String title, int commentCount, Member writer});

  $MemberCopyWith<$Res> get writer;
}

/// @nodoc
class _$PostOutlineCopyWithImpl<$Res, $Val extends PostOutline>
    implements $PostOutlineCopyWith<$Res> {
  _$PostOutlineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostOutline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? title = null,
    Object? commentCount = null,
    Object? writer = null,
  }) {
    return _then(
      _value.copyWith(
            postId:
                null == postId
                    ? _value.postId
                    : postId // ignore: cast_nullable_to_non_nullable
                        as int,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            commentCount:
                null == commentCount
                    ? _value.commentCount
                    : commentCount // ignore: cast_nullable_to_non_nullable
                        as int,
            writer:
                null == writer
                    ? _value.writer
                    : writer // ignore: cast_nullable_to_non_nullable
                        as Member,
          )
          as $Val,
    );
  }

  /// Create a copy of PostOutline
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MemberCopyWith<$Res> get writer {
    return $MemberCopyWith<$Res>(_value.writer, (value) {
      return _then(_value.copyWith(writer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostOutlineImplCopyWith<$Res>
    implements $PostOutlineCopyWith<$Res> {
  factory _$$PostOutlineImplCopyWith(
    _$PostOutlineImpl value,
    $Res Function(_$PostOutlineImpl) then,
  ) = __$$PostOutlineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int postId, String title, int commentCount, Member writer});

  @override
  $MemberCopyWith<$Res> get writer;
}

/// @nodoc
class __$$PostOutlineImplCopyWithImpl<$Res>
    extends _$PostOutlineCopyWithImpl<$Res, _$PostOutlineImpl>
    implements _$$PostOutlineImplCopyWith<$Res> {
  __$$PostOutlineImplCopyWithImpl(
    _$PostOutlineImpl _value,
    $Res Function(_$PostOutlineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostOutline
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = null,
    Object? title = null,
    Object? commentCount = null,
    Object? writer = null,
  }) {
    return _then(
      _$PostOutlineImpl(
        postId:
            null == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                    as int,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        commentCount:
            null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                    as int,
        writer:
            null == writer
                ? _value.writer
                : writer // ignore: cast_nullable_to_non_nullable
                    as Member,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostOutlineImpl implements _PostOutline {
  const _$PostOutlineImpl({
    required this.postId,
    required this.title,
    required this.commentCount,
    required this.writer,
  });

  factory _$PostOutlineImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostOutlineImplFromJson(json);

  @override
  final int postId;
  @override
  final String title;
  @override
  final int commentCount;
  @override
  final Member writer;

  @override
  String toString() {
    return 'PostOutline(postId: $postId, title: $title, commentCount: $commentCount, writer: $writer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostOutlineImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.writer, writer) || other.writer == writer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, postId, title, commentCount, writer);

  /// Create a copy of PostOutline
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostOutlineImplCopyWith<_$PostOutlineImpl> get copyWith =>
      __$$PostOutlineImplCopyWithImpl<_$PostOutlineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostOutlineImplToJson(this);
  }
}

abstract class _PostOutline implements PostOutline {
  const factory _PostOutline({
    required final int postId,
    required final String title,
    required final int commentCount,
    required final Member writer,
  }) = _$PostOutlineImpl;

  factory _PostOutline.fromJson(Map<String, dynamic> json) =
      _$PostOutlineImpl.fromJson;

  @override
  int get postId;
  @override
  String get title;
  @override
  int get commentCount;
  @override
  Member get writer;

  /// Create a copy of PostOutline
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostOutlineImplCopyWith<_$PostOutlineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
