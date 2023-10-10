import 'dart:async';

import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/model/activeLine_model.dart';
import 'package:iot_app/core/model/companyInfo_model.dart';
import 'package:iot_app/core/model/iot_device_model.dart';
import 'package:iot_app/services/iotapi_service.dart';
import 'package:iot_app/utils/app-pref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends StreamViewModel<List<IotDeviceModel>> {
  final _navigationService = locator<NavigationService>();
  final _iotService = locator<IotapiService>();
  List<IotDeviceModel> devices = <IotDeviceModel>[];
  CompanyInfoModel? companyInfoModel;
  StreamSubscription? _subscription;
  ActiveLineModel? _lineModel;
  List<DataModel>? lineData;
  bool isDataReady = false;

  Future<void> initialize() async {
    AppPref.getHomeAssistantUrl();
    try {
      companyInfoModel = await AppPref.getCompanyInfo();
      _lineModel = await AppPref.getActiveLine();
      lineData = _lineModel?.data;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void showDialog() {
    _navigationService.navigateTo('/add-device-view');
  }

  void showBottomSheet() {
    _navigationService.navigateTo('/profile-view');
  }

  @override
  // TODO: implement streamSubscription
  StreamSubscription? get streamSubscription => _subscription;

  @override
  // TODO: implement dataReady
  bool get dataReady => super.dataReady;

  @override
  // TODO: implement stream
  Stream<List<IotDeviceModel>> get stream => getDevice();
  Stream<List<IotDeviceModel>> getDevice() async* {
    devices.clear();
    _subscription?.cancel();
    for (var device in await _iotService.getDevice()) {
      int idx = devices.indexWhere((element) => element.id == device.id);
      if (idx >= 0) {
        devices[idx] = device;
        notifyListeners();
      } else {
        devices.add(device);
        notifyListeners();
      }
    }
    yield devices;
    await Future.delayed(Duration(seconds: 10));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
