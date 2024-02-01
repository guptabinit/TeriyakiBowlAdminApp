import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teriyaki_bowl_admin_app/models/timestamp_converter.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  @TimestampConverter()
  const factory Order({
    @JsonKey(name: 'oid') String? id,
    @JsonKey(name: 'accepted_time') DateTime? acceptedTime,
    @JsonKey(name: 'order_total') double? orderTotal,
    @JsonKey(name: 'payment_completed') bool? paymentCompleted,
    @JsonKey(name: 'order_status') int? orderStatus,
    @JsonKey(name: 'order_accepted') int? orderAccepted,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}
