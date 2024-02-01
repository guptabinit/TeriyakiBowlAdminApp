// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: json['oid'] as String?,
      acceptedTime: const TimestampConverter()
          .fromJson(json['accepted_time'] as Timestamp?),
      orderTotal: (json['order_total'] as num?)?.toDouble(),
      paymentCompleted: json['payment_completed'] as bool?,
      orderStatus: json['order_status'] as int?,
      orderAccepted: json['order_accepted'] as int?,
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'oid': instance.id,
      'accepted_time': const TimestampConverter().toJson(instance.acceptedTime),
      'order_total': instance.orderTotal,
      'payment_completed': instance.paymentCompleted,
      'order_status': instance.orderStatus,
      'order_accepted': instance.orderAccepted,
    };
