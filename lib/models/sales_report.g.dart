// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SalesReportImpl _$$SalesReportImplFromJson(Map<String, dynamic> json) =>
    _$SalesReportImpl(
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$$SalesReportImplToJson(_$SalesReportImpl instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'count': instance.count,
    };
