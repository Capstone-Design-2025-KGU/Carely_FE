import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carely/models/member.dart';

part 'res_memo_dto.freezed.dart';
part 'res_memo_dto.g.dart';

@freezed
class ResMemoDTO with _$ResMemoDTO {
  const factory ResMemoDTO({
    required int memoId,
    String? walk,
    String? health,
    String? medic,
    String? meal,
    String? toilet,
    String? comm,
  }) = _ResMemoDTO;

  factory ResMemoDTO.fromJson(Map<String, dynamic> json) =>
      _$ResMemoDTOFromJson(json);
}

// DateTime 컨버터 함수
DateTime _dateTimeFromList(List<dynamic> json) {
  return DateTime.utc(
    json[0],
    json[1],
    json[2],
    json[3],
    json[4],
    json[5],
    (json[6] as int) ~/ 1000000,
  );
}

List<int> _dateTimeToList(DateTime dt) {
  return [
    dt.year,
    dt.month,
    dt.day,
    dt.hour,
    dt.minute,
    dt.second,
    dt.microsecond * 1000,
  ];
}
