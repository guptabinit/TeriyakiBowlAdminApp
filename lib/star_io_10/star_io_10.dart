import 'package:flutter/services.dart';
import 'package:teriyaki_bowl_admin_app/star_io_10/src/interface_type.dart';
import 'package:teriyaki_bowl_admin_app/star_io_10/src/star_printer.dart';
import 'package:teriyaki_bowl_admin_app/star_io_10/src/types.dart';

export 'src/interface_type.dart';
export 'src/star_printer.dart';
export 'src/types.dart';

class StarIO10 {
  const StarIO10._();

  static const MethodChannel _channel =
      MethodChannel('com.teriyaki-bowl/star-io10');

  static Future<void> startDiscovery({
    required InterfaceType type,
    required PrinterFoundCallback onPrinterFound,
    required DiscoveryFinishedCallback onDiscoveryFinished,
    required DiscoveryFailedCallback onDiscoveryFailed,
  }) async {
    try {
      Map<dynamic, dynamic>? result = await _channel.invokeMethod(
        'startDiscovery',
        <String, dynamic>{'interfaceType': type.name},
      );
      if (result != null) {
        onPrinterFound(StarPrinter.fromMap(result.cast<String, dynamic>()));
      } else {
        onDiscoveryFinished();
      }
    } on PlatformException catch (e) {
      onDiscoveryFailed(e.message ?? 'Printer not found');
    } catch (e) {
      onDiscoveryFailed(e.toString());
    }
  }

  static Future<void> print({
    required StarPrinter printer,
    required Map<String, dynamic> printingData,
    required PrintFailedCallback onFailed,
  }) async {
    try {
      Map<String, dynamic> arguments = {
        ...printer.asMap(),
        ...printingData,
      };
      return await _channel.invokeMethod('print', arguments);
    } on PlatformException catch (e) {
      onFailed(e.message ?? 'Please try again');
    } catch (e) {
      onFailed(e.toString());
    }
  }
}
