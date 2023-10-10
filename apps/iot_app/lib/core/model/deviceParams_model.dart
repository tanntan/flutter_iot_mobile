import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:iot_app/core/model/param_model.dart';

class DeviceParams {
  final BluetoothDevice? device;
  final ParamModel params;

  DeviceParams({required ParamModel param, required BluetoothDevice scanResult})
      : device = scanResult,
        params = param;

  @override
  String toString() {
    return 'DeviceParams {param: $params, device: $device}';
  }

  Map<String, dynamic> toMap() {
    return {
      'device': device,
      'params': params,
    };
  }
}
