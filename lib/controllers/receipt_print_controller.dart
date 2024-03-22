import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:teriyaki_bowl_admin_app/main.dart';
import 'package:teriyaki_bowl_admin_app/star_io_10/star_io_10.dart';

class ReceiptPrintController extends GetxController {
  final Rx<InterfaceType> _interfaceType = Rx(InterfaceType.lan);

  final Rx<List<StarPrinter>> _printers = Rx(<StarPrinter>[]);

  final RxBool _loading = RxBool(false);

  @override
  void onInit() async {
    _printers.value.clear();
    _interfaceType.value = InterfaceType.lan;
    StarPrinter? printer = ReceiptPrintController.starPrinter;
    if (printer != null) {
      _printers.update((val) {
        val?.add(printer);
      });
    }
    super.onInit();
  }

  Future<void> startDiscovery(BuildContext context) async {
    _loading.value = true;
    StarIO10.startDiscovery(
      type: _interfaceType.value,
      onPrinterFound: (printer) {
        bool isExists = _printers.value.where((e) {
          return e.identifier == printer.identifier &&
              e.interfaceType == printer.interfaceType;
        }).isEmpty;

        if (isExists) {
          _printers.update((val) {
            val?.add(printer);
          });
        } else {
          _showSnackBar(
            context,
            '${printer.model ?? 'Unknown'} is already Connected.',
          );
        }
        _loading.value = false;
      },
      onDiscoveryFinished: () {
        _loading.value = false;
        _showSnackBar(context, 'Print not found. Please try again');
      },
      onDiscoveryFailed: (message) {
        _loading.value = false;
        _showSnackBar(context, message);
      },
    );
  }

  void updateInterfaceType(InterfaceType type) {
    _interfaceType.value = type;
  }

  void connectPrinter(BuildContext context, StarPrinter printer) {
    preferences
        ?.setString('starPrinter', jsonEncode(printer.asMap()))
        .whenComplete(() {
      _printers.refresh();
      _showSnackBar(context, 'Connected with ${printer.model}');
    });
    _printers.refresh();
  }

  void disconnectPrinter(BuildContext context, StarPrinter printer) {
    preferences?.remove('starPrinter').whenComplete(() {
      _printers.refresh();
      _showSnackBar(context, '${printer.model} Disconnected');
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessengerState state = ScaffoldMessenger.of(context);
    state
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  static Future<void> onPrintReceipt(dynamic data) async {
    int totalLength = 42;

    final headerBuffer = StringBuffer();
    final bodyBuffer = StringBuffer();
    final footerBuffer = StringBuffer();

    headerBuffer.writeln('              Teriyaki Bowl               ');

    String customerName = data['name'];
    headerBuffer.writeln('Customer Name: $customerName');

    String time = _convertDateFormat(data['pickup_time']);
    headerBuffer.writeln('Pickup Time: $time');

    String orderNumber = data['oid'];
    bodyBuffer.writeln('Order Number: #$orderNumber');

    String paymentMode = data['is_cod'] ? 'Cash' : 'Credit';
    footerBuffer.writeln('Payment Mode: $paymentMode');

    List<String> itemIds = List<String>.from(data['cart']['items']);
    footerBuffer.writeln('Total Items: ${itemIds.length} Items');

    footerBuffer.writeln(List.generate(totalLength, (index) => '-').join());

    for (String itemId in itemIds) {
      dynamic item = data['cart'][itemId];

      String firstPart = '${item['quantity']} x ${item['item_name']}';
      String secondPart = '\$${item['total_price'].toStringAsFixed(2)}';

      int length = totalLength - (firstPart.length + secondPart.length);

      String? modifiers = item['selectedAddon'].join(', ');

      String? specialInstruction =
          item['specialInstruction'] == '' ? null : item['specialInstruction'];

      footerBuffer.writeln(
          firstPart + List.generate((length), (_) => ' ').join() + secondPart);

      if (modifiers != null && modifiers.isNotEmpty) {
        footerBuffer.writeln(modifiers);
      }

      if (specialInstruction != null) {
        footerBuffer.writeln('Sp. Instruction: $specialInstruction');
        footerBuffer.writeln(List.generate(totalLength, (index) => '-').join());
      } else {
        footerBuffer.writeln(List.generate(totalLength, (index) => '-').join());
      }
    }

    String subTotal = '\$${data['cart']['cart_amount'].toStringAsFixed(2)}';
    footerBuffer.writeln(
        'Subtotal${List.generate((totalLength - (8 + subTotal.length)), (_) => ' ').join()}$subTotal');

    String tax = '\$${data['tax_amount'].toStringAsFixed(2)}';
    footerBuffer.writeln(
        'Tax${List.generate((totalLength - (3 + tax.length)), (_) => ' ').join()}$tax');

    String total = '\$${data['order_total'].toStringAsFixed(2)}';
    footerBuffer.writeln(
        'Total${List.generate((totalLength - (5 + total.length)), (_) => ' ').join()}$total');

    footerBuffer.toString().log();

    StarPrinter? printer = ReceiptPrintController.starPrinter;
    if (printer == null) {
      Get.snackbar(
        'Error',
        'Printer not found',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      return;
    }
    return StarIO10.print(
      printer: printer,
      headerPrintingData: headerBuffer.toString(),
      bodyPrintingData: bodyBuffer.toString(),
      footerPrintingData: footerBuffer.toString(),
      onFailed: (message) {
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      },
    );
  }

  static String _convertDateFormat(String inputString) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy hh:mm a');

    DateTime parsedDateTime = dateFormat.parse(inputString);

    String formattedDateTime =
        DateFormat('MM-dd-yyyy hh:mm a').format(parsedDateTime);

    return formattedDateTime;
  }

  static StarPrinter? get starPrinter {
    String? printerStr = preferences?.getString('starPrinter');

    StarPrinter? printer;

    if (printerStr != null) {
      printer = StarPrinter.fromMap(jsonDecode(printerStr));
    }
    return printer;
  }

  List<StarPrinter> get printers => _printers.value;

  InterfaceType get interfaceType => _interfaceType.value;

  bool get loading => _loading.value;
}
