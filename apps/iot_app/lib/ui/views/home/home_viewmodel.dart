import 'dart:async';

import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/app/app.router.dart';
import 'package:iot_app/core/iotapi_provider.dart';
import 'package:iot_app/core/model/activeLine_model.dart';
import 'package:iot_app/core/model/companyInfo_model.dart';
import 'package:iot_app/core/model/iot_device_model.dart';
import 'package:iot_app/core/websocket_provider.dart';
import 'package:iot_app/utils/app-pref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends StreamViewModel<List<IotDeviceModel>> {
  final navigationService = locator<NavigationService>();
  final iotProvider = locator<IotApiProvider>();

  final websocketProvider = locator<WebSocketProvider>();

  CompanyInfoModel? companyInfoModel;
  ActiveLineModel? _lineModel;
  List<DataModel>? lineData;
  bool isDataReady = false;

  Future<void> initialize() async {
    AppPref.getHomeAssistantUrl();

    notifyListeners();
    try {
      companyInfoModel = await AppPref.getCompanyInfo();
      _lineModel = await AppPref.getActiveLine();
      lineData = _lineModel?.data;
      websocketProvider.getEntity();
      // ignore: empty_catches
    } catch (e) {
      rethrow;
    }
  }

  void showDialog() {
    navigationService.navigateToAddDeviceView();
  }

  void showBottomSheet() {
    navigationService.navigateTo('/profile-view');
  }

  @override
  Stream<List<IotDeviceModel>> get stream => getDeviceStream();

  Stream<List<IotDeviceModel>> getDeviceStream() async* {
    while (true) {
      List<IotDeviceModel>? iotDevices;
      iotDevices = await iotProvider.getDevice();
      yield iotDevices;
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  void dispose() {
    websocketProvider.dispose();
    super.dispose();
  }
}
