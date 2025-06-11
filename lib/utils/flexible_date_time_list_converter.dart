import 'package:freezed_annotation/freezed_annotation.dart';

class FlexibleDateTimeConverter implements JsonConverter<DateTime?, dynamic> {
  const FlexibleDateTimeConverter();

  @override
  DateTime? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is List) {
      if (json.length >= 3) {
        // 3개 요소: [year, month, day]
        if (json.length == 3) {
          return DateTime(
            json[0], // year
            json[1], // month
            json[2], // day
          );
        }
        // 6개 이상 요소: [year, month, day, hour, minute, second, ...]
        else if (json.length >= 6) {
          return DateTime(
            json[0], // year
            json[1], // month
            json[2], // day
            json[3], // hour
            json[4], // minute
            json[5], // second
            json.length > 6
                ? (json[6] / 1000000).round()
                : 0, // microsecond (optional)
          );
        }
      }
    } else if (json is String) {
      return DateTime.parse(json);
    } else {
      throw Exception('Unexpected DateTime format: $json');
    }
    return null;
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
