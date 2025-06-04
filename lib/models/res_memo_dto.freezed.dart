// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'res_memo_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ResMemoDTO _$ResMemoDTOFromJson(Map<String, dynamic> json) {
  return _ResMemoDTO.fromJson(json);
}

/// @nodoc
mixin _$ResMemoDTO {
  int get memoId => throw _privateConstructorUsedError;
  String? get walk => throw _privateConstructorUsedError;
  String? get health => throw _privateConstructorUsedError;
  String? get medic => throw _privateConstructorUsedError;
  String? get meal => throw _privateConstructorUsedError;
  String? get toilet => throw _privateConstructorUsedError;
  String? get comm => throw _privateConstructorUsedError;

  /// Serializes this ResMemoDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResMemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResMemoDTOCopyWith<ResMemoDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResMemoDTOCopyWith<$Res> {
  factory $ResMemoDTOCopyWith(
    ResMemoDTO value,
    $Res Function(ResMemoDTO) then,
  ) = _$ResMemoDTOCopyWithImpl<$Res, ResMemoDTO>;
  @useResult
  $Res call({
    int memoId,
    String? walk,
    String? health,
    String? medic,
    String? meal,
    String? toilet,
    String? comm,
  });
}

/// @nodoc
class _$ResMemoDTOCopyWithImpl<$Res, $Val extends ResMemoDTO>
    implements $ResMemoDTOCopyWith<$Res> {
  _$ResMemoDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResMemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoId = null,
    Object? walk = freezed,
    Object? health = freezed,
    Object? medic = freezed,
    Object? meal = freezed,
    Object? toilet = freezed,
    Object? comm = freezed,
  }) {
    return _then(
      _value.copyWith(
            memoId:
                null == memoId
                    ? _value.memoId
                    : memoId // ignore: cast_nullable_to_non_nullable
                        as int,
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
            meal:
                freezed == meal
                    ? _value.meal
                    : meal // ignore: cast_nullable_to_non_nullable
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResMemoDTOImplCopyWith<$Res>
    implements $ResMemoDTOCopyWith<$Res> {
  factory _$$ResMemoDTOImplCopyWith(
    _$ResMemoDTOImpl value,
    $Res Function(_$ResMemoDTOImpl) then,
  ) = __$$ResMemoDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int memoId,
    String? walk,
    String? health,
    String? medic,
    String? meal,
    String? toilet,
    String? comm,
  });
}

/// @nodoc
class __$$ResMemoDTOImplCopyWithImpl<$Res>
    extends _$ResMemoDTOCopyWithImpl<$Res, _$ResMemoDTOImpl>
    implements _$$ResMemoDTOImplCopyWith<$Res> {
  __$$ResMemoDTOImplCopyWithImpl(
    _$ResMemoDTOImpl _value,
    $Res Function(_$ResMemoDTOImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ResMemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoId = null,
    Object? walk = freezed,
    Object? health = freezed,
    Object? medic = freezed,
    Object? meal = freezed,
    Object? toilet = freezed,
    Object? comm = freezed,
  }) {
    return _then(
      _$ResMemoDTOImpl(
        memoId:
            null == memoId
                ? _value.memoId
                : memoId // ignore: cast_nullable_to_non_nullable
                    as int,
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
        meal:
            freezed == meal
                ? _value.meal
                : meal // ignore: cast_nullable_to_non_nullable
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
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResMemoDTOImpl implements _ResMemoDTO {
  const _$ResMemoDTOImpl({
    required this.memoId,
    this.walk,
    this.health,
    this.medic,
    this.meal,
    this.toilet,
    this.comm,
  });

  factory _$ResMemoDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResMemoDTOImplFromJson(json);

  @override
  final int memoId;
  @override
  final String? walk;
  @override
  final String? health;
  @override
  final String? medic;
  @override
  final String? meal;
  @override
  final String? toilet;
  @override
  final String? comm;

  @override
  String toString() {
    return 'ResMemoDTO(memoId: $memoId, walk: $walk, health: $health, medic: $medic, meal: $meal, toilet: $toilet, comm: $comm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResMemoDTOImpl &&
            (identical(other.memoId, memoId) || other.memoId == memoId) &&
            (identical(other.walk, walk) || other.walk == walk) &&
            (identical(other.health, health) || other.health == health) &&
            (identical(other.medic, medic) || other.medic == medic) &&
            (identical(other.meal, meal) || other.meal == meal) &&
            (identical(other.toilet, toilet) || other.toilet == toilet) &&
            (identical(other.comm, comm) || other.comm == comm));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, memoId, walk, health, medic, meal, toilet, comm);

  /// Create a copy of ResMemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResMemoDTOImplCopyWith<_$ResMemoDTOImpl> get copyWith =>
      __$$ResMemoDTOImplCopyWithImpl<_$ResMemoDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResMemoDTOImplToJson(this);
  }
}

abstract class _ResMemoDTO implements ResMemoDTO {
  const factory _ResMemoDTO({
    required final int memoId,
    final String? walk,
    final String? health,
    final String? medic,
    final String? meal,
    final String? toilet,
    final String? comm,
  }) = _$ResMemoDTOImpl;

  factory _ResMemoDTO.fromJson(Map<String, dynamic> json) =
      _$ResMemoDTOImpl.fromJson;

  @override
  int get memoId;
  @override
  String? get walk;
  @override
  String? get health;
  @override
  String? get medic;
  @override
  String? get meal;
  @override
  String? get toilet;
  @override
  String? get comm;

  /// Create a copy of ResMemoDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResMemoDTOImplCopyWith<_$ResMemoDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
