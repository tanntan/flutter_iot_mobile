import 'package:esp_provisioning/esp_provisioning.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/ble_provider.dart';

import 'package:iot_app/core/model/activeLine_model.dart';
import 'package:iot_app/core/model/deviceParams_model.dart';
import 'package:iot_app/services/ble_service.dart';
import 'package:iot_app/utils/app-pref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BlueConnectViewModel extends BaseViewModel {
  final bleProvider = locator<BleProvider>();

  final navigationService = locator<NavigationService>();

  final bleService = locator<BleService>();
  bool? status;
  EspProv? prov;
  List<DeviceParams> deviceWithparam = <DeviceParams>[];
  ActiveLineModel allActiveLine = ActiveLineModel();
  List<DataModel> allLineData = <DataModel>[];
  Future<void> initialize() async {
    try {
      deviceWithparam = bleProvider.deviceParam;
      allActiveLine = await AppPref.getActiveLine();
      allLineData = allActiveLine.data ?? [];
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  void typeSearch(String? value) async {
    List<DataModel> activeLine = allActiveLine.data!
        .where((element) =>
            element.lineName!.toLowerCase().contains(value!.toLowerCase()))
        .toList();
    allLineData = activeLine;
    notifyListeners();
  }

  void submitHandler() {
    bleProvider.setDeviceBleParams(deviceWithparam);
    navigationService.navigateTo('/blewifi-view');
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
