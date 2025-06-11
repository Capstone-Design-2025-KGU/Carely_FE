import 'package:freezed_annotation/freezed_annotation.dart';

class FlexibleDateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  const FlexibleDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;

    if (json is List && json.length >= 6) {
      return DateTime(
        json[0], // year
        json[1], // month
        json[2], // day
        json[3], // hour
        json[4], // minute
        json[5], // second
        json.length >= 7 ? (json[6] / 1000000).round() : 0, // millisecond
      );
    }

    if (json is String) {
      return DateTime.parse(json);
    }

    throw Exception('Unexpected DateTime format: $json');
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
