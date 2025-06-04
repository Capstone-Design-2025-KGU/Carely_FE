import 'package:carely/models/member.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearest_meeting.freezed.dart';
part 'nearest_meeting.g.dart';

@freezed
class NearestMeeting with _$NearestMeeting {
  const factory NearestMeeting({
    required int meetingId,
    required Member sender,
    required Member receiver,
    required DateTime startTime,
    required int memoId,
    String? walk,
    String? health,
    String? medic,
    String? toilet,
    String? comm,
    String? meal,
  }) = _NearestMeeting;

  factory NearestMeeting.fromJson(Map<String, dynamic> json) =>
      _$NearestMeetingFromJson(json);
}
