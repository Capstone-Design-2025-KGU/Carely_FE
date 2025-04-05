import 'package:carely/models/address.dart';
import 'package:carely/models/skill.dart';
import 'package:carely/utils/flexible_date_time_list_converter.dart';
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
    required String name,
    required String phoneNumber,

    @JsonKey(fromJson: _birthFromJson) required String birth,

    String? story,

    @MemberTypeConverter() required MemberType memberType,

    required bool isVisible,
    required bool isVerified,
    String? profileImage,

    @FlexibleDateTimeConverter() DateTime? createdAt,

    required Address address,
    required Skill skill,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}

// [2001, 10, 30] → "2001-10-30"
String _birthFromJson(List<dynamic> birthList) {
  if (birthList.length >= 3) {
    final year = birthList[0];
    final month = birthList[1].toString().padLeft(2, '0');
    final day = birthList[2].toString().padLeft(2, '0');
    return '$year-$month-$day';
  }
  return '';
}
