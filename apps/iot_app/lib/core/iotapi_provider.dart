import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/model/iot_device_model.dart';
import 'package:iot_app/services/iotapi_service.dart';
import 'package:stacked/stacked.dart';

class IotApiProvider extends StreamViewModel<List<IotDeviceModel>> {
  final _iotservice = locator<IotapiService>();
  List<IotDeviceModel> _deviceList = <IotDeviceModel>[];
  @override
  // TODO: implement stream
  Stream<List<IotDeviceModel>> get stream => getDevice();

  Stream<List<IotDeviceModel>> getDevice() async* {
    List<IotDeviceModel>? newDevices;
    newDevices = await _iotservice.getDevice();

    yield newDevices;
    await Future.delayed(Duration(seconds: 10));
  }

  Future postIotDevice(IotDeviceModel body) async {
    _deviceList = await _iotservice.getDevice();
    if (_deviceList.isEmpty) {
      await _iotservice.postDevice(body);
    } else {
      int contain =
          _deviceList.indexWhere((device) => device.serial == body.serial);
      if (contain < 0) {
        await _iotservice.postDevice(body);
      } else {
        await putIotDevice(body, _deviceList[contain].id ?? 0);
      }
    }
  }

  Future putIotDevice(IotDeviceModel body, int idx) async {
    try {
      await _iotservice.updateDevice(body, idx);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
