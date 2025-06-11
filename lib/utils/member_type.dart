import 'package:freezed_annotation/freezed_annotation.dart';

enum MemberType { family, volunteer, caregiver }

class MemberTypeConverter implements JsonConverter<MemberType, String> {
  const MemberTypeConverter();

  @override
  MemberType fromJson(String json) {
    switch (json.toLowerCase()) {
      case 'family':
        return MemberType.family;
      case 'volunteer':
        return MemberType.volunteer;
      case 'caregiver':
        return MemberType.caregiver;
      default:
        throw ArgumentError(
          '$json is not one of the supported values: family, volunteer, caregiver',
        );
    }
  }

  @override
  String toJson(MemberType object) {
    return object.name.toUpperCase();
  }
}

String displayMemberType(MemberType? type) {
  switch (type) {
    case MemberType.family:
      return '가족 간병인';
    case MemberType.volunteer:
      return '자원봉사자';
    case MemberType.caregiver:
      return '예비 요양보호사';
    default:
      return '회원';
  }
}
