// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MapMemberImpl _$$MapMemberImplFromJson(Map<String, dynamic> json) =>
    _$MapMemberImpl(
      memberId: (json['memberId'] as num).toInt(),
      username: json['username'] as String,
      name: json['name'] as String,
      birth: _birthFromJson(json['birth']),
      age: (json['age'] as num).toInt(),
      story: json['story'] as String?,
      memberType: const MemberTypeConverter().fromJson(
        json['memberType'] as String,
      ),
      profileImage: json['profileImage'] as String?,
      distance: (json['distance'] as num).toDouble(),
      withTime: (json['withTime'] as num).toInt(),
      address:
          json['address'] == null
              ? null
              : Address.fromJson(json['address'] as Map<String, dynamic>),
      skill:
          json['skill'] == null
              ? null
              : Skill.fromJson(json['skill'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MapMemberImplToJson(_$MapMemberImpl instance) =>
    <String, dynamic>{
      'memberId': instance.memberId,
      'username': instance.username,
      'name': instance.name,
      'birth': instance.birth,
      'age': instance.age,
      'story': instance.story,
      'memberType': const MemberTypeConverter().toJson(instance.memberType),
      'profileImage': instance.profileImage,
      'distance': instance.distance,
      'withTime': instance.withTime,
      'address': instance.address?.toJson(),
      'skill': instance.skill?.toJson(),
    };
