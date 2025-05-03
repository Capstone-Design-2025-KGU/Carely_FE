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
