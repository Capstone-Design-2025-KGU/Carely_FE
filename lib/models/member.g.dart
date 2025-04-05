// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
  memberId: (json['memberId'] as num).toInt(),
  username: json['username'] as String,
  name: json['name'] as String,
  phoneNumber: json['phoneNumber'] as String,
  birth: _birthFromJson(json['birth'] as List),
  story: json['story'] as String?,
  memberType: $enumDecode(_$MemberTypeEnumMap, json['memberType']),
  isVisible: json['isVisible'] as bool,
  isVerified: json['isVerified'] as bool,
  profileImage: json['profileImage'] as String?,
  createdAt: _dateTimeFromJson(json['createdAt'] as List),
  address: Address.fromJson(json['address'] as Map<String, dynamic>),
  skill: Skill.fromJson(json['skill'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'username': instance.username,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'birth': instance.birth,
      'story': instance.story,
      'memberType': _$MemberTypeEnumMap[instance.memberType]!,
      'isVisible': instance.isVisible,
      'isVerified': instance.isVerified,
      'profileImage': instance.profileImage,
      'createdAt': instance.createdAt?.toIso8601String(),
      'address': instance.address.toJson(),
      'skill': instance.skill.toJson(),
    };

const _$MemberTypeEnumMap = {
  MemberType.family: 'family',
  MemberType.volunteer: 'volunteer',
  MemberType.caregiver: 'caregiver',
};
