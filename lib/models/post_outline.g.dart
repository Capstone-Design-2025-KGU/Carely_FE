// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_outline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostOutlineImpl _$$PostOutlineImplFromJson(Map<String, dynamic> json) =>
    _$PostOutlineImpl(
      postId: (json['postId'] as num).toInt(),
      title: json['title'] as String,
      commentCount: (json['commentCount'] as num).toInt(),
      writer: Member.fromJson(json['writer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostOutlineImplToJson(_$PostOutlineImpl instance) =>
    <String, dynamic>{
      'postId': instance.postId,
      'title': instance.title,
      'commentCount': instance.commentCount,
      'writer': instance.writer,
    };
