// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  int get memberId => throw _privateConstructorUsedError;
  String get memberName => throw _privateConstructorUsedError;
  @MemberTypeConverter()
  MemberType get memberType => throw _privateConstructorUsedError;
  String get profileImage => throw _privateConstructorUsedError;
  int get chatRoomId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get participantCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call({
    int memberId,
    String memberName,
    @MemberTypeConverter() MemberType memberType,
    String profileImage,
    int chatRoomId,
    String content,
    int participantCount,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? memberName = null,
    Object? memberType = null,
    Object? profileImage = null,
    Object? chatRoomId = null,
    Object? content = null,
    Object? participantCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            memberId:
                null == memberId
                    ? _value.memberId
                    : memberId // ignore: cast_nullable_to_non_nullable
                        as int,
            memberName:
                null == memberName
                    ? _value.memberName
                    : memberName // ignore: cast_nullable_to_non_nullable
                        as String,
            memberType:
                null == memberType
                    ? _value.memberType
                    : memberType // ignore: cast_nullable_to_non_nullable
                        as MemberType,
            profileImage:
                null == profileImage
                    ? _value.profileImage
                    : profileImage // ignore: cast_nullable_to_non_nullable
                        as String,
            chatRoomId:
                null == chatRoomId
                    ? _value.chatRoomId
                    : chatRoomId // ignore: cast_nullable_to_non_nullable
                        as int,
            content:
                null == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String,
            participantCount:
                null == participantCount
                    ? _value.participantCount
                    : participantCount // ignore: cast_nullable_to_non_nullable
                        as int,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatRoomImplCopyWith<$Res>
    implements $ChatRoomCopyWith<$Res> {
  factory _$$ChatRoomImplCopyWith(
    _$ChatRoomImpl value,
    $Res Function(_$ChatRoomImpl) then,
  ) = __$$ChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int memberId,
    String memberName,
    @MemberTypeConverter() MemberType memberType,
    String profileImage,
    int chatRoomId,
    String content,
    int participantCount,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$ChatRoomImplCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$ChatRoomImpl>
    implements _$$ChatRoomImplCopyWith<$Res> {
  __$$ChatRoomImplCopyWithImpl(
    _$ChatRoomImpl _value,
    $Res Function(_$ChatRoomImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memberId = null,
    Object? memberName = null,
    Object? memberType = null,
    Object? profileImage = null,
    Object? chatRoomId = null,
    Object? content = null,
    Object? participantCount = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ChatRoomImpl(
        memberId:
            null == memberId
                ? _value.memberId
                : memberId // ignore: cast_nullable_to_non_nullable
                    as int,
        memberName:
            null == memberName
                ? _value.memberName
                : memberName // ignore: cast_nullable_to_non_nullable
                    as String,
        memberType:
            null == memberType
                ? _value.memberType
                : memberType // ignore: cast_nullable_to_non_nullable
                    as MemberType,
        profileImage:
            null == profileImage
                ? _value.profileImage
                : profileImage // ignore: cast_nullable_to_non_nullable
                    as String,
        chatRoomId:
            null == chatRoomId
                ? _value.chatRoomId
                : chatRoomId // ignore: cast_nullable_to_non_nullable
                    as int,
        content:
            null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String,
        participantCount:
            null == participantCount
                ? _value.participantCount
                : participantCount // ignore: cast_nullable_to_non_nullable
                    as int,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ChatRoomImpl implements _ChatRoom {
  const _$ChatRoomImpl({
    required this.memberId,
    required this.memberName,
    @MemberTypeConverter() required this.memberType,
    required this.profileImage,
    required this.chatRoomId,
    required this.content,
    required this.participantCount,
    this.createdAt,
  });

  factory _$ChatRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomImplFromJson(json);

  @override
  final int memberId;
  @override
  final String memberName;
  @override
  @MemberTypeConverter()
  final MemberType memberType;
  @override
  final String profileImage;
  @override
  final int chatRoomId;
  @override
  final String content;
  @override
  final int participantCount;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ChatRoom(memberId: $memberId, memberName: $memberName, memberType: $memberType, profileImage: $profileImage, chatRoomId: $chatRoomId, content: $content, participantCount: $participantCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomImpl &&
            (identical(other.memberId, memberId) ||
                other.memberId == memberId) &&
            (identical(other.memberName, memberName) ||
                other.memberName == memberName) &&
            (identical(other.memberType, memberType) ||
                other.memberType == memberType) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.participantCount, participantCount) ||
                other.participantCount == participantCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    memberId,
    memberName,
    memberType,
    profileImage,
    chatRoomId,
    content,
    participantCount,
    createdAt,
  );

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      __$$ChatRoomImplCopyWithImpl<_$ChatRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomImplToJson(this);
  }
}

abstract class _ChatRoom implements ChatRoom {
  const factory _ChatRoom({
    required final int memberId,
    required final String memberName,
    @MemberTypeConverter() required final MemberType memberType,
    required final String profileImage,
    required final int chatRoomId,
    required final String content,
    required final int participantCount,
    final DateTime? createdAt,
  }) = _$ChatRoomImpl;

  factory _ChatRoom.fromJson(Map<String, dynamic> json) =
      _$ChatRoomImpl.fromJson;

  @override
  int get memberId;
  @override
  String get memberName;
  @override
  @MemberTypeConverter()
  MemberType get memberType;
  @override
  String get profileImage;
  @override
  int get chatRoomId;
  @override
  String get content;
  @override
  int get participantCount;
  @override
  DateTime? get createdAt;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
