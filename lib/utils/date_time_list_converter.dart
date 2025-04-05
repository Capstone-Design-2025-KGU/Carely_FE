import 'package:json_annotation/json_annotation.dart';

class DateTimeListConverter
    implements JsonConverter<DateTime?, List<dynamic>?> {
  const DateTimeListConverter();

  @override
  DateTime? fromJson(List<dynamic>? json) {
    if (json == null || json.length < 7) return null;
    return DateTime(
      json[0],
      json[1],
      json[2],
      json[3],
      json[4],
      json[5],
      (json[6] / 1000000).round(), // 나노초 → 밀리초
    );
  }

  @override
  List<dynamic>? toJson(DateTime? object) {
    if (object == null) return null;
    return [
      object.year,
      object.month,
      object.day,
      object.hour,
      object.minute,
      object.second,
      object.millisecond * 1000000,
    ];
  }
}
