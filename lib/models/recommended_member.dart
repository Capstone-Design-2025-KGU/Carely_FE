import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carely/utils/member_type.dart';

part 'recommended_member.freezed.dart';
part 'recommended_member.g.dart';

@freezed
class RecommendedMember with _$RecommendedMember {
  const factory RecommendedMember({
    required int memberId,
    required String name,
    String? profileImage,
    @MemberTypeConverter() required MemberType memberType,
    required double distance,
    required int withTime,
  }) = _RecommendedMember;

  factory RecommendedMember.fromJson(Map<String, dynamic> json) =>
      _$RecommendedMemberFromJson(json);
}
