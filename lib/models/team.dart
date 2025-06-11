import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:carely/models/address.dart';

part 'team.freezed.dart';
part 'team.g.dart';

@freezed
class Team with _$Team {
  const factory Team({
    required int teamId,
    required String teamName,
    required Address address,
    String? story,
    required int memberCount,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}
