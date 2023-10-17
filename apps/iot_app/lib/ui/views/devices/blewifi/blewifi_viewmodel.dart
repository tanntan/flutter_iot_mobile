import 'package:esp_provisioning/esp_provisioning.dart';

import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/ble_provider.dart';
import 'package:iot_app/services/ble_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BlewifiViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  EspProv? prov;
  final bleProvider = locator<BleProvider>();
  final bleService = locator<BleService>();
  bool? status;

  Map<String, dynamic> wifiController = {};
  Future initialize() async {}

  Future provisionBle() async {
    bleProvider.wifiController = wifiController;
    await navigationService.navigateTo('/provision-view');
  }

  Future handleCancel() async {
    bool isCancel = await bleProvider.discardProv();
    if (isCancel) {
      await navigationService.navigateTo('/home-view');
    }
  }

  @override
  void dispose() {
    bleProvider.deviceParam.clear();
    super.dispose();
  }
}
