import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:teriyaki_bowl_admin_app/models/order.dart';
import 'package:teriyaki_bowl_admin_app/models/sales_report.dart';
import 'package:teriyaki_bowl_admin_app/utils/colors.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  DateTime? startDate = DateTime.now();
  DateTime? endDate;

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      if (args.value?.startDate != null) {
        startDate = args.value.startDate as DateTime;
      } else {
        startDate = null;
      }
      if (args.value?.endDate != null) {
        endDate = args.value.endDate as DateTime;
      } else {
        endDate = null;
      }
    }
    setState(() {});
  }

  Stream<SalesReport> _getSalesReport({
    DateTime? startDate,
    DateTime? endDate,
  }) {
    var query = FirebaseFirestore.instance
        .collection('allOrders')
        .where('payment_completed', isEqualTo: true);

    if (startDate != null && endDate != null) {
      query = query.where(
        'accepted_time',
        isGreaterThan: startDate,
        isLessThan: DateTime(
          endDate.year,
          endDate.month,
          endDate.day + 1,
        ),
      );
    } else if (startDate != null && endDate == null) {
      query = query.where(
        'accepted_time',
        isGreaterThan: DateTime(
          startDate.year,
          startDate.month,
          startDate.day,
        ),
        isLessThan: DateTime(
          startDate.year,
          startDate.month,
          startDate.day + 1,
        ),
      );
    } else {
      final date = DateTime.now();
      query = query.where(
        'accepted_time',
        isGreaterThan: DateTime(
          date.year,
          date.month,
          date.day,
        ),
        isLessThan: DateTime(
          date.year,
          date.month,
          date.day + 1,
        ),
      );
    }

    return query.snapshots().map(
          (snapshots) => snapshots.docs.map(
            (e) {
              final order = Order.fromJson(e.data());
              return order;
            },
          ).fold(
            SalesReport.empty,
            (previousReport, order) {
              return previousReport.copyWith(
                totalAmount:
                    (previousReport.totalAmount ?? 0) + (order.orderTotal ?? 0),
                count: (previousReport.count ?? 0) + 1,
              );
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text(
          "Sales Report",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: lightColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: lightColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: onSelectionChanged,
              ),
              StreamBuilder(
                stream: _getSalesReport(
                  startDate: startDate,
                  endDate: endDate,
                ),
                builder: (context, snapshot) {
                  return ListTile(
                    title: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: 'Total Successful Sales: '),
                          TextSpan(
                            text: '${snapshot.data?.count ?? 0}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Text(
                      '\$${snapshot.data?.totalAmount?.toStringAsFixed(2) ?? 0}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
