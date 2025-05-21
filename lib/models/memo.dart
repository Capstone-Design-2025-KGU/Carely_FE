import 'package:carely/models/member.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'memo.freezed.dart';
part 'memo.g.dart';

@freezed
class Memo with _$Memo {
  @JsonSerializable(explicitToJson: true)
  const factory Memo({
    required int meetingId,
    required Member receiver,
    required Member sender,
    required DateTime startTime,
    required int memoId,
    String? walk,
    String? health,
    String? medic,
    String? toilet,
    String? comm,
    String? meal,
  }) = _Memo;

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);
}
