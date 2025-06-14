// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemberImpl _$$MemberImplFromJson(Map<String, dynamic> json) => _$MemberImpl(
  memberId: (json['memberId'] as num).toInt(),
  username: json['username'] as String,
  password: json['password'] as String?,
  name: json['name'] as String,
  phoneNumber: json['phoneNumber'] as String?,
  birth: _birthFromJson(json['birth']),
  story: json['story'] as String?,
  memberType: const MemberTypeConverter().fromJson(
    json['memberType'] as String,
  ),
  isVisible: json['isVisible'] as bool?,
  isVerified: json['isVerified'] as bool?,
  profileImage: json['profileImage'] as String?,
  address:
      json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
  skill:
      json['skill'] == null
          ? null
          : Skill.fromJson(json['skill'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$MemberImplToJson(_$MemberImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'username': instance.username,
      'password': instance.password,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'birth': instance.birth,
      'story': instance.story,
      'memberType': const MemberTypeConverter().toJson(instance.memberType),
      'isVisible': instance.isVisible,
      'isVerified': instance.isVerified,
      'profileImage': instance.profileImage,
      'address': instance.address?.toJson(),
      'skill': instance.skill?.toJson(),
    };
