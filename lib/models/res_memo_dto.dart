import 'package:freezed_annotation/freezed_annotation.dart';

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
