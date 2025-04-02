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
    required String name,
    required String phoneNumber,
    required String birth,
    String? story,
    required MemberType memberType,
    required bool isVisible,
    required bool isVerified,
    String? profileImage,
    DateTime? createdAt,
    required Address address,
    required Skill skill,
  }) = _Member;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
}
