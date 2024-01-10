import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_admin_app/common/widgets/custom_button.dart';
import 'package:teriyaki_bowl_admin_app/controllers/receipt_print_controller.dart';
import 'package:teriyaki_bowl_admin_app/star_io_10/star_io_10.dart';
import 'package:teriyaki_bowl_admin_app/utils/colors.dart';

class ReceiptPrintPage extends StatefulWidget {
  const ReceiptPrintPage({super.key});

  @override
  State<ReceiptPrintPage> createState() => _ReceiptPrintPageState();
}

class _ReceiptPrintPageState extends State<ReceiptPrintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Receipt Print',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: lightColor,
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: lightColor,
          ),
        ),
      ),
      body: GetX<ReceiptPrintController>(
        init: ReceiptPrintController(),
        builder: (printController) {
          return Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInterfaceTypeDropdown(
                      value: printController.interfaceType,
                      onChanged: (value) {
                        if (value == null) return;
                        printController.updateInterfaceType(value);
                      },
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: CustomButton(
                        btnText: 'Find Printer',
                        onTap: () {
                          printController.startDiscovery(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: Text(
                        'Available Printers',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Expanded(
                      child: _buildAvailablePrintersListView(printController),
                    ),
                  ],
                ),
              ),
              if (printController.loading)
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.15),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAvailablePrintersListView(
      ReceiptPrintController printController) {
    if (printController.printers.isNotEmpty) {
      return ListView.separated(
        itemCount: printController.printers.length,
        separatorBuilder: (context, index) => const Divider(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          StarPrinter printer = printController.printers[index];

          StarPrinter? currentPrinter = ReceiptPrintController.getStarPrinter();

          bool connected =
              currentPrinter?.interfaceType == printer.interfaceType &&
                  currentPrinter?.identifier == printer.identifier;

          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.print, color: primaryColor),
            ),
            title: Text(
              printer.model ?? 'Unknown',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              printer.interfaceType.displayName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: connected ? Colors.red : Colors.green,
              ),
              child: Text(
                connected ? 'Disconnect' : 'Connect',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              if (connected) {
                printController.disconnectPrinter(context, printer);
              } else {
                printController.connectPrinter(context, printer);
              }
            },
          );
        },
      );
    } else {
      return const Center(
        child: Text(
          'No Printers',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
    }
  }

  Widget _buildInterfaceTypeDropdown({
    required InterfaceType value,
    required void Function(InterfaceType?)? onChanged,
  }) {
    OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 2),
          child: Text(
            'Interface Type',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonHideUnderline(
          child: DropdownButtonFormField<InterfaceType>(
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              border: inputBorder,
              enabledBorder: inputBorder,
              focusedBorder: inputBorder,
            ),
            items: [
              InterfaceType.lan,
              InterfaceType.usb,
              InterfaceType.bluetooth,
              if (Platform.isIOS) InterfaceType.bluetoothLE,
            ].map(
              (e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e.displayName),
                );
              },
            ).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
