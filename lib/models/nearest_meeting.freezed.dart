// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nearest_meeting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NearestMeeting _$NearestMeetingFromJson(Map<String, dynamic> json) {
  return _NearestMeeting.fromJson(json);
}

/// @nodoc
mixin _$NearestMeeting {
  int get meetingId => throw _privateConstructorUsedError;
  Member get sender => throw _privateConstructorUsedError;
  Member get receiver => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  int? get memoId => throw _privateConstructorUsedError;
  String? get walk => throw _privateConstructorUsedError;
  String? get health => throw _privateConstructorUsedError;
  String? get medic => throw _privateConstructorUsedError;
  String? get toilet => throw _privateConstructorUsedError;
  String? get comm => throw _privateConstructorUsedError;
  String? get meal => throw _privateConstructorUsedError;

  /// Serializes this NearestMeeting to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NearestMeeting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NearestMeetingCopyWith<NearestMeeting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NearestMeetingCopyWith<$Res> {
  factory $NearestMeetingCopyWith(
    NearestMeeting value,
    $Res Function(NearestMeeting) then,
  ) = _$NearestMeetingCopyWithImpl<$Res, NearestMeeting>;
  @useResult
  $Res call({
    int meetingId,
    Member sender,
    Member receiver,
    DateTime startTime,
    int? memoId,
    String? walk,
    String? health,
    String? medic,
    String? toilet,
    String? comm,
    String? meal,
  });

  $MemberCopyWith<$Res> get sender;
  $MemberCopyWith<$Res> get receiver;
}

/// @nodoc
class _$NearestMeetingCopyWithImpl<$Res, $Val extends NearestMeeting>
    implements $NearestMeetingCopyWith<$Res> {
  _$NearestMeetingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NearestMeeting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? sender = null,
    Object? receiver = null,
    Object? startTime = null,
    Object? memoId = freezed,
    Object? walk = freezed,
    Object? health = freezed,
    Object? medic = freezed,
    Object? toilet = freezed,
    Object? comm = freezed,
    Object? meal = freezed,
  }) {
    return _then(
      _value.copyWith(
            meetingId:
                null == meetingId
                    ? _value.meetingId
                    : meetingId // ignore: cast_nullable_to_non_nullable
                        as int,
            sender:
                null == sender
                    ? _value.sender
                    : sender // ignore: cast_nullable_to_non_nullable
                        as Member,
            receiver:
                null == receiver
                    ? _value.receiver
                    : receiver // ignore: cast_nullable_to_non_nullable
                        as Member,
            startTime:
                null == startTime
                    ? _value.startTime
                    : startTime // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            memoId:
                freezed == memoId
                    ? _value.memoId
                    : memoId // ignore: cast_nullable_to_non_nullable
                        as int?,
            walk:
                freezed == walk
                    ? _value.walk
                    : walk // ignore: cast_nullable_to_non_nullable
                        as String?,
            health:
                freezed == health
                    ? _value.health
                    : health // ignore: cast_nullable_to_non_nullable
                        as String?,
            medic:
                freezed == medic
                    ? _value.medic
                    : medic // ignore: cast_nullable_to_non_nullable
                        as String?,
            toilet:
                freezed == toilet
                    ? _value.toilet
                    : toilet // ignore: cast_nullable_to_non_nullable
                        as String?,
            comm:
                freezed == comm
                    ? _value.comm
                    : comm // ignore: cast_nullable_to_non_nullable
                        as String?,
            meal:
                freezed == meal
                    ? _value.meal
                    : meal // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of NearestMeeting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MemberCopyWith<$Res> get sender {
    return $MemberCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }

  /// Create a copy of NearestMeeting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MemberCopyWith<$Res> get receiver {
    return $MemberCopyWith<$Res>(_value.receiver, (value) {
      return _then(_value.copyWith(receiver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NearestMeetingImplCopyWith<$Res>
    implements $NearestMeetingCopyWith<$Res> {
  factory _$$NearestMeetingImplCopyWith(
    _$NearestMeetingImpl value,
    $Res Function(_$NearestMeetingImpl) then,
  ) = __$$NearestMeetingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int meetingId,
    Member sender,
    Member receiver,
    DateTime startTime,
    int? memoId,
    String? walk,
    String? health,
    String? medic,
    String? toilet,
    String? comm,
    String? meal,
  });

  @override
  $MemberCopyWith<$Res> get sender;
  @override
  $MemberCopyWith<$Res> get receiver;
}

/// @nodoc
class __$$NearestMeetingImplCopyWithImpl<$Res>
    extends _$NearestMeetingCopyWithImpl<$Res, _$NearestMeetingImpl>
    implements _$$NearestMeetingImplCopyWith<$Res> {
  __$$NearestMeetingImplCopyWithImpl(
    _$NearestMeetingImpl _value,
    $Res Function(_$NearestMeetingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NearestMeeting
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meetingId = null,
    Object? sender = null,
    Object? receiver = null,
    Object? startTime = null,
    Object? memoId = freezed,
    Object? walk = freezed,
    Object? health = freezed,
    Object? medic = freezed,
    Object? toilet = freezed,
    Object? comm = freezed,
    Object? meal = freezed,
  }) {
    return _then(
      _$NearestMeetingImpl(
        meetingId:
            null == meetingId
                ? _value.meetingId
                : meetingId // ignore: cast_nullable_to_non_nullable
                    as int,
        sender:
            null == sender
                ? _value.sender
                : sender // ignore: cast_nullable_to_non_nullable
                    as Member,
        receiver:
            null == receiver
                ? _value.receiver
                : receiver // ignore: cast_nullable_to_non_nullable
                    as Member,
        startTime:
            null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        memoId:
            freezed == memoId
                ? _value.memoId
                : memoId // ignore: cast_nullable_to_non_nullable
                    as int?,
        walk:
            freezed == walk
                ? _value.walk
                : walk // ignore: cast_nullable_to_non_nullable
                    as String?,
        health:
            freezed == health
                ? _value.health
                : health // ignore: cast_nullable_to_non_nullable
                    as String?,
        medic:
            freezed == medic
                ? _value.medic
                : medic // ignore: cast_nullable_to_non_nullable
                    as String?,
        toilet:
            freezed == toilet
                ? _value.toilet
                : toilet // ignore: cast_nullable_to_non_nullable
                    as String?,
        comm:
            freezed == comm
                ? _value.comm
                : comm // ignore: cast_nullable_to_non_nullable
                    as String?,
        meal:
            freezed == meal
                ? _value.meal
                : meal // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NearestMeetingImpl implements _NearestMeeting {
  const _$NearestMeetingImpl({
    required this.meetingId,
    required this.sender,
    required this.receiver,
    required this.startTime,
    this.memoId,
    this.walk,
    this.health,
    this.medic,
    this.toilet,
    this.comm,
    this.meal,
  });

  factory _$NearestMeetingImpl.fromJson(Map<String, dynamic> json) =>
      _$$NearestMeetingImplFromJson(json);

  @override
  final int meetingId;
  @override
  final Member sender;
  @override
  final Member receiver;
  @override
  final DateTime startTime;
  @override
  final int? memoId;
  @override
  final String? walk;
  @override
  final String? health;
  @override
  final String? medic;
  @override
  final String? toilet;
  @override
  final String? comm;
  @override
  final String? meal;

  @override
  String toString() {
    return 'NearestMeeting(meetingId: $meetingId, sender: $sender, receiver: $receiver, startTime: $startTime, memoId: $memoId, walk: $walk, health: $health, medic: $medic, toilet: $toilet, comm: $comm, meal: $meal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NearestMeetingImpl &&
            (identical(other.meetingId, meetingId) ||
                other.meetingId == meetingId) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.memoId, memoId) || other.memoId == memoId) &&
            (identical(other.walk, walk) || other.walk == walk) &&
            (identical(other.health, health) || other.health == health) &&
            (identical(other.medic, medic) || other.medic == medic) &&
            (identical(other.toilet, toilet) || other.toilet == toilet) &&
            (identical(other.comm, comm) || other.comm == comm) &&
            (identical(other.meal, meal) || other.meal == meal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    meetingId,
    sender,
    receiver,
    startTime,
    memoId,
    walk,
    health,
    medic,
    toilet,
    comm,
    meal,
  );

  /// Create a copy of NearestMeeting
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NearestMeetingImplCopyWith<_$NearestMeetingImpl> get copyWith =>
      __$$NearestMeetingImplCopyWithImpl<_$NearestMeetingImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NearestMeetingImplToJson(this);
  }
}

abstract class _NearestMeeting implements NearestMeeting {
  const factory _NearestMeeting({
    required final int meetingId,
    required final Member sender,
    required final Member receiver,
    required final DateTime startTime,
    final int? memoId,
    final String? walk,
    final String? health,
    final String? medic,
    final String? toilet,
    final String? comm,
    final String? meal,
  }) = _$NearestMeetingImpl;

  factory _NearestMeeting.fromJson(Map<String, dynamic> json) =
      _$NearestMeetingImpl.fromJson;

  @override
  int get meetingId;
  @override
  Member get sender;
  @override
  Member get receiver;
  @override
  DateTime get startTime;
  @override
  int? get memoId;
  @override
  String? get walk;
  @override
  String? get health;
  @override
  String? get medic;
  @override
  String? get toilet;
  @override
  String? get comm;
  @override
  String? get meal;

  /// Create a copy of NearestMeeting
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NearestMeetingImplCopyWith<_$NearestMeetingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
