import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:json_annotation/json_annotation.dart' show JsonConverter;

class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Timestamp? timestamp) => timestamp?.toDate();

  @override
  Timestamp? toJson(DateTime? date) =>
      date == null ? null : Timestamp.fromDate(date);
}
