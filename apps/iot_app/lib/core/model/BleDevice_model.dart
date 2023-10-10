// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleDevice {
  final BluetoothDevice bluetoothDevice;
  final String name;
  int rssi;

  String get id => bluetoothDevice.remoteId.toString();

  BleDevice(ScanResult scanResult)
      : bluetoothDevice = scanResult.device,
        // name = scanResult.device.name ?? scanResult.advertisementData.localName ?? "Unknown",
        name = scanResult.device.localName,
        rssi = scanResult.rssi;

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(other) =>
      other is BleDevice &&
      compareAsciiLowerCase(this.name, other.name) == 0 &&
      this.id == other.id &&
      this.rssi == other.rssi;

  @override
  String toString() {
    return 'BleDevice {name: $name, id: $id, rssid: $rssi}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rssi': rssi,
      'peripheral': bluetoothDevice,
    };
  }

  int compareTo(BleDevice other) {
    if (rssi > other.rssi) {
      return -1;
    }
    if (rssi == other.rssi) {
      return 0;
    }
    return 1;
  }
}
