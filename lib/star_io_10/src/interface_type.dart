enum InterfaceType { unknown, usb, bluetooth, bluetoothLE, lan }

extension InterfaceTypeEx on InterfaceType {
  String get name => toString().split('.').last;

  bool get isBluetoothLE => this == InterfaceType.bluetoothLE;

  String get displayName {
    switch (this) {
      case InterfaceType.lan:
        return 'LAN';
      case InterfaceType.usb:
        return 'USB';
      case InterfaceType.bluetooth:
        return 'Bluetooth';
      case InterfaceType.bluetoothLE:
        return 'BluetoothLE';
      default:
        return 'Unknown';
    }
  }
}
