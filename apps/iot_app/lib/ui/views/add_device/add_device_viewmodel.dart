import 'dart:async';
import 'dart:io';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/ble_provider.dart';
import 'package:iot_app/core/model/deviceParams_model.dart';
import 'package:iot_app/core/model/param_model.dart';
import 'package:iot_app/services/ble_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:stacked_services/stacked_services.dart';

class AddDeviceViewModel extends StreamViewModel<List<BluetoothDevice>> {
  final _bleService = locator<BleService>();
  final _bleProvider = locator<BleProvider>();

  StreamSubscription<List<ScanResult>>? _scanSubscription;

  List<BluetoothDevice> bleDevices = <BluetoothDevice>[];

  List<BluetoothDevice> getList = <BluetoothDevice>[];
  final _navigationService = locator<NavigationService>();
  Guid uuid = Guid('021a9004-0382-4aea-bff4-6b3f1c5adfb4');

  bool isDataReady = false;

  Future<void> initial() async {
    try {
      if (await FlutterBluePlus.isAvailable == false) {
        print("object");
        return;
      }
      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn();
      }
      await FlutterBluePlus.adapterState
          .map((s) {
            print(s);
            return s;
          })
          .where((s) => s == BluetoothAdapterState.on)
          .first;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  // TODO: implement dataReady
  bool get dataReady {
    Future.delayed(Duration(seconds: 5));
    return isDataReady;
  }

  @override
  // TODO: implement stream
  Stream<List<BluetoothDevice>> get stream => scanDevice();

  Stream<List<BluetoothDevice>> scanDevice() async* {
    while (!isDataReady) {
      await getData();
      yield bleDevices;
    }
  }

  Future getData() async {
    var permissionIsGranted = await _bleService.requestBlePermissions();
    if (!permissionIsGranted) {
      await Permission.locationWhenInUse.request();
      return;
    }
    var bleState = await _bleService.start();
    if (bleState == BluetoothAdapterState.unauthorized) {
      return;
    }
    _scanSubscription?.cancel();
    _scanSubscription =
        _bleService.scanBle([uuid]).listen((List<ScanResult> scanResults) {
      scanResults.forEach((ScanResult scanResult) {
        var bleDevice = BluetoothDevice(
            remoteId: scanResult.device.remoteId,
            localName: scanResult.device.localName,
            type: scanResult.device.type);

        var idx =
            bleDevices.indexWhere((e) => e.remoteId == bleDevice.remoteId);
        if (idx < 0) {
          bleDevices.add(bleDevice);
        } else {
          bleDevices[idx] = bleDevice;
        }
        notifyListeners();
      });
    });
    await Future.delayed(Duration(seconds: 5));
    isDataReady = bleDevices.isNotEmpty;
    notifyListeners();
  }

  void selecthalder(BluetoothDevice device) {
    DeviceParams pDevice =
        DeviceParams(param: ParamModel(), scanResult: device);

    int idx = _bleProvider.deviceParam.indexWhere(
      (element) => element.device!.localName == device.localName,
    );
    if (idx >= 0) {
      _bleProvider.deviceParam.removeAt(idx);
      getList.remove(device);
      notifyListeners();
    } else {
      _bleProvider.deviceParam.add(pDevice);
      getList.add(device);
      notifyListeners();
    }
    notifyListeners();
  }

  void deselectall() {
    getList.clear();
    notifyListeners();
  }

  void connectBle() async {
    await _navigationService.navigateTo('/blue-connect-view');
    deselectall();
  }

  void reloadHandler() {
    bleDevices.clear();
    isDataReady = false;
    getData();
    deselectall();
    notifyListeners();
  }

  @override
  void dispose() {
    print('dispose');
    _bleService.stopScanBle();
    _scanSubscription!.cancel();
    super.dispose();
  }
}
