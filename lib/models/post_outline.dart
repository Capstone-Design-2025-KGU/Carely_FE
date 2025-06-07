import 'package:carely/models/member.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_outline.freezed.dart';
part 'post_outline.g.dart';

@freezed
class PostOutline with _$PostOutline {
  const factory PostOutline({
    required int postId,
    required String title,
    required int commentCount,
    required Member writer,
  }) = _PostOutline;

  factory PostOutline.fromJson(Map<String, dynamic> json) =>
      _$PostOutlineFromJson(json);
}
