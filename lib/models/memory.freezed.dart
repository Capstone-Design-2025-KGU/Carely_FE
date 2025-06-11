// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Memory _$MemoryFromJson(Map<String, dynamic> json) {
  return _Memory.fromJson(json);
}

/// @nodoc
mixin _$Memory {
  int get memoryId => throw _privateConstructorUsedError;
  String get oppoName => throw _privateConstructorUsedError;
  @MemberTypeConverter()
  MemberType get memberType => throw _privateConstructorUsedError;
  String? get oppoMemo => throw _privateConstructorUsedError;

  /// Serializes this Memory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemoryCopyWith<Memory> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoryCopyWith<$Res> {
  factory $MemoryCopyWith(Memory value, $Res Function(Memory) then) =
      _$MemoryCopyWithImpl<$Res, Memory>;
  @useResult
  $Res call({
    int memoryId,
    String oppoName,
    @MemberTypeConverter() MemberType memberType,
    String? oppoMemo,
  });
}

/// @nodoc
class _$MemoryCopyWithImpl<$Res, $Val extends Memory>
    implements $MemoryCopyWith<$Res> {
  _$MemoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoryId = null,
    Object? oppoName = null,
    Object? memberType = null,
    Object? oppoMemo = freezed,
  }) {
    return _then(
      _value.copyWith(
            memoryId:
                null == memoryId
                    ? _value.memoryId
                    : memoryId // ignore: cast_nullable_to_non_nullable
                        as int,
            oppoName:
                null == oppoName
                    ? _value.oppoName
                    : oppoName // ignore: cast_nullable_to_non_nullable
                        as String,
            memberType:
                null == memberType
                    ? _value.memberType
                    : memberType // ignore: cast_nullable_to_non_nullable
                        as MemberType,
            oppoMemo:
                freezed == oppoMemo
                    ? _value.oppoMemo
                    : oppoMemo // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MemoryImplCopyWith<$Res> implements $MemoryCopyWith<$Res> {
  factory _$$MemoryImplCopyWith(
    _$MemoryImpl value,
    $Res Function(_$MemoryImpl) then,
  ) = __$$MemoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int memoryId,
    String oppoName,
    @MemberTypeConverter() MemberType memberType,
    String? oppoMemo,
  });
}

/// @nodoc
class __$$MemoryImplCopyWithImpl<$Res>
    extends _$MemoryCopyWithImpl<$Res, _$MemoryImpl>
    implements _$$MemoryImplCopyWith<$Res> {
  __$$MemoryImplCopyWithImpl(
    _$MemoryImpl _value,
    $Res Function(_$MemoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoryId = null,
    Object? oppoName = null,
    Object? memberType = null,
    Object? oppoMemo = freezed,
  }) {
    return _then(
      _$MemoryImpl(
        memoryId:
            null == memoryId
                ? _value.memoryId
                : memoryId // ignore: cast_nullable_to_non_nullable
                    as int,
        oppoName:
            null == oppoName
                ? _value.oppoName
                : oppoName // ignore: cast_nullable_to_non_nullable
                    as String,
        memberType:
            null == memberType
                ? _value.memberType
                : memberType // ignore: cast_nullable_to_non_nullable
                    as MemberType,
        oppoMemo:
            freezed == oppoMemo
                ? _value.oppoMemo
                : oppoMemo // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MemoryImpl implements _Memory {
  const _$MemoryImpl({
    required this.memoryId,
    required this.oppoName,
    @MemberTypeConverter() required this.memberType,
    this.oppoMemo,
  });

  factory _$MemoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemoryImplFromJson(json);

  @override
  final int memoryId;
  @override
  final String oppoName;
  @override
  @MemberTypeConverter()
  final MemberType memberType;
  @override
  final String? oppoMemo;

  @override
  String toString() {
    return 'Memory(memoryId: $memoryId, oppoName: $oppoName, memberType: $memberType, oppoMemo: $oppoMemo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoryImpl &&
            (identical(other.memoryId, memoryId) ||
                other.memoryId == memoryId) &&
            (identical(other.oppoName, oppoName) ||
                other.oppoName == oppoName) &&
            (identical(other.memberType, memberType) ||
                other.memberType == memberType) &&
            (identical(other.oppoMemo, oppoMemo) ||
                other.oppoMemo == oppoMemo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, memoryId, oppoName, memberType, oppoMemo);

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoryImplCopyWith<_$MemoryImpl> get copyWith =>
      __$$MemoryImplCopyWithImpl<_$MemoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemoryImplToJson(this);
  }
}

abstract class _Memory implements Memory {
  const factory _Memory({
    required final int memoryId,
    required final String oppoName,
    @MemberTypeConverter() required final MemberType memberType,
    final String? oppoMemo,
  }) = _$MemoryImpl;

  factory _Memory.fromJson(Map<String, dynamic> json) = _$MemoryImpl.fromJson;

  @override
  int get memoryId;
  @override
  String get oppoName;
  @override
  @MemberTypeConverter()
  MemberType get memberType;
  @override
  String? get oppoMemo;

  /// Create a copy of Memory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoryImplCopyWith<_$MemoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
