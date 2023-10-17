import 'package:iot_app/app/app.dialogs.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/model/deviceParams_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BleProvider extends BaseViewModel {
  static final BleProvider _singleton = BleProvider._internal();
  factory BleProvider() {
    return _singleton;
  }
  BleProvider._internal();
  final _dialogService = locator<DialogService>();

  Map<String, dynamic> wifiController = {};

  List<DeviceParams> deviceParam = <DeviceParams>[];

  void addBleDevice(DeviceParams device) {
    int idx = deviceParam
        .indexWhere((p) => p.device?.remoteId == device.device!.remoteId);

    if (idx >= 0) {
      deviceParam.removeAt(idx);
      notifyListeners();
    } else {
      deviceParam.add(device);
      notifyListeners();
    }
  }

  void setDeviceBleParams(List<DeviceParams>? deviceParams) {
    deviceParam = deviceParams!;
    notifyListeners();
  }

  void setWiFiAp(Map<String, dynamic>? wifi) {
    wifiController['ssid'] = wifi?['ssid'] ?? 'none';
    wifiController['password'] = wifi?['password'] ?? 'none';

    notifyListeners();
  }

  Future<bool> discardProv() async {
    var dialog = await _dialogService.showCustomDialog(
      variant: DialogType.alertDialog,
      title: 'Discard Provisioning',
      description: 'Are you sure want to discard?',
      secondaryButtonTitle: 'Cancel',
      mainButtonTitle: 'Discard',
    );
    if (dialog!.confirmed) {
      deviceParam.clear();
      return true;
    }
    return false;
  }
}
