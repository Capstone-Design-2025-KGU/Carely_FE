import 'package:carely/models/address.dart';
import 'package:carely/models/skill.dart';
import 'package:carely/utils/member_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'member.freezed.dart';
part 'member.g.dart';

@freezed
class Member with _$Member {
  @JsonSerializable(explicitToJson: true)
  const factory Member({
    required int memberId,
    required String username,
    String? password,
    required String name,
    String? phoneNumber,

    @JsonKey(fromJson: _birthFromJson) required String birth,

    String? story,

    @MemberTypeConverter() required MemberType memberType,

    bool? isVisible,
    bool? isVerified,
    String? profileImage,

    Address? address,
    Skill? skill,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}

// [2001, 10, 30] → "2001-10-30"
String _birthFromJson(dynamic birthJson) {
  if (birthJson is List && birthJson.length >= 3) {
    final year = birthJson[0];
    final month = birthJson[1].toString().padLeft(2, '0');
    final day = birthJson[2].toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
  return '';
}
