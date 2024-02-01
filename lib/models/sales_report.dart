import 'package:freezed_annotation/freezed_annotation.dart';

part 'sales_report.freezed.dart';

part 'sales_report.g.dart';

@freezed
class SalesReport with _$SalesReport {
  const factory SalesReport({
    double? totalAmount,
    int? count,
  }) = _SalesReport;

  static const empty = SalesReport(
    count: 0,
    totalAmount: 0,
  );

  factory SalesReport.fromJson(Map<String, dynamic> json) =>
      _$SalesReportFromJson(json);
}
