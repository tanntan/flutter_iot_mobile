import 'package:esp_provisioning/esp_provisioning.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/ble_provider.dart';
import 'package:iot_app/core/iotapi_provider.dart';
import 'package:iot_app/core/model/companyInfo_model.dart';
import 'package:iot_app/core/model/deviceParams_model.dart';
import 'package:iot_app/core/model/iot_device_model.dart';
import 'package:iot_app/services/ble_service.dart';
import 'package:iot_app/ui/common/ui_helpers.dart';
import 'package:iot_app/utils/app-pref.dart';
import 'package:rive/rive.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProvisionViewModel extends BaseViewModel {
  final _bleProvider = locator<BleProvider>();
  final _bleService = locator<BleService>();
  final _navigationService = locator<NavigationService>();
  final _iotProvider = locator<IotApiProvider>();

  SMITrigger? check;
  SMITrigger? cError;
  SMITrigger? reset;

  bool info = false;
  EspProv? prov;
  Future initialize() async {
    reset?.fire();
    CompanyInfoModel companyInfoModel = await AppPref.getCompanyInfo();
    for (DeviceParams device in _bleProvider.deviceParam) {
      device.params.gmtOffset = DateTime.now().timeZoneOffset.inSeconds;
      device.params.environment = companyInfoModel.company;
      device.params.mqttServer = 'mqtt-dev.ltlabs.co';
      try {
        notifyListeners();
        prov =
            await _bleService.startProvisioning(bluetoothDevice: device.device);

        await prov?.establishSession();
        await prov?.sendReceiveCustomData(encodeCustomData(device.params));

        await prov?.sendWifiConfig(
            ssid: _bleProvider.wifiController['ssid'],
            password: _bleProvider.wifiController['password']);
        await prov?.applyWifiConfig();

        IotDeviceModel iotDevice = IotDeviceModel(
            name: device.params.deviceName,
            serial: device.device?.localName,
            status: true,
            lineName: device.params.line,
            stationId: device.params.station,
            remark: "remak",
            description: "description",
            version: "version");
        await _iotProvider.postIotDevice(iotDevice);
        // ignore: prefer_const_constructors
        await Future.delayed(Duration(seconds: 2));
        info = true;
        notifyListeners();
      } catch (e) {
        cError?.fire();
      }
    }
    check?.fire();
  }

  void provisionHandler() {
    _bleProvider.deviceParam.clear();
    _bleProvider.wifiController.clear();
    _navigationService.navigateTo('/home-view');
  }

  @override
  void dispose() {
    prov?.dispose();
    super.dispose();
  }
}
