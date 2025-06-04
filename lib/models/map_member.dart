import 'package:carely/models/address.dart';
import 'package:carely/models/skill.dart';
import 'package:carely/utils/flexible_date_time_list_converter.dart';
import 'package:carely/utils/member_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_member.freezed.dart';
part 'map_member.g.dart';

@freezed
class MapMember with _$MapMember {
  @JsonSerializable(explicitToJson: true)
  const factory MapMember({
    required int memberId,
    required String username,
    required String name,
    @JsonKey(fromJson: _birthFromJson) required String birth,
    required int age,
    String? story,
    @MemberTypeConverter() required MemberType memberType,
    String? profileImage,
    @FlexibleDateTimeConverter() required DateTime createdAt,
    required double distance,
    required int withTime,
    Address? address,
    Skill? skill,
  }) = _MapMember;

  factory MapMember.fromJson(Map<String, dynamic> json) =>
      _$MapMemberFromJson(json);
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
