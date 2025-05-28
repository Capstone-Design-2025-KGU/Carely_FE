import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory.freezed.dart';
part 'memory.g.dart';

@freezed
class Memory with _$Memory {
  const factory Memory({
    required int memoryId,
    required String oppoName,
    required String oppoMemo,
  }) = _Memory;

  factory Memory.fromJson(Map<String, dynamic> json) => _$MemoryFromJson(json);
}
