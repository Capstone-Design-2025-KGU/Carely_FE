// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecommendedMemberImpl _$$RecommendedMemberImplFromJson(
  Map<String, dynamic> json,
) => _$RecommendedMemberImpl(
  memberId: (json['memberId'] as num).toInt(),
  name: json['name'] as String,
  profileImage: json['profileImage'] as String?,
  memberType: const MemberTypeConverter().fromJson(
    json['memberType'] as String,
  ),
  distance: (json['distance'] as num).toDouble(),
  withTime: (json['withTime'] as num).toInt(),
);

Map<String, dynamic> _$$RecommendedMemberImplToJson(
  _$RecommendedMemberImpl instance,
) => <String, dynamic>{
  'memberId': instance.memberId,
  'name': instance.name,
  'profileImage': instance.profileImage,
  'memberType': const MemberTypeConverter().toJson(instance.memberType),
  'distance': instance.distance,
  'withTime': instance.withTime,
};
