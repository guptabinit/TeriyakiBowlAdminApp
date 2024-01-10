import 'package:teriyaki_bowl_admin_app/star_io_10/src/interface_type.dart';

class StarPrinter {
  final String? model;
  final InterfaceType interfaceType;
  final String? identifier;

  const StarPrinter({
    this.model,
    this.interfaceType = InterfaceType.unknown,
    this.identifier,
  });

  factory StarPrinter.fromMap(Map<String, dynamic> map) {
    return StarPrinter(
      model: map['model'],
      interfaceType: InterfaceType.values.firstWhere(
        (e) => e.name.toLowerCase() == map['interfaceType'].toLowerCase(),
        orElse: () => InterfaceType.unknown,
      ),
      identifier: map['identifier'],
    );
  }

  Map<String, dynamic> asMap() {
    return {
      'model': model,
      'interfaceType': interfaceType.name,
      'identifier': identifier,
    };
  }
}
