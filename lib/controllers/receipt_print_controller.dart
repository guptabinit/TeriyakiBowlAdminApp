import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    StarPrinter? printer = ReceiptPrintController.getStarPrinter();
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

  static StarPrinter? getStarPrinter() {
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
