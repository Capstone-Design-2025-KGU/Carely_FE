import 'package:freezed_annotation/freezed_annotation.dart';

class FlexibleDateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  const FlexibleDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is List && json.length >= 7) {
      return DateTime(
        json[0],
        json[1],
        json[2],
        json[3],
        json[4],
        json[5],
        (json[6] / 1000000).round(),
      );
    } else if (json is String) {
      return DateTime.parse(json);
    } else {
      throw Exception('Unexpected DateTime format: $json');
    }
  }

  @override
  dynamic toJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return [
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime.millisecond * 1000000,
    ];
  }
}
