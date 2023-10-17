import 'package:flutter/material.dart';
import 'package:iot_app/core/json_str.dart';
import 'package:iot_app/core/login_provider.dart';
import 'package:iot_app/core/ltie_provider.dart';
import 'package:iot_app/core/websocket_provider.dart';
import 'package:iot_app/utils/app-pref.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:stacked/stacked.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _globalAdmin = locator<LoginProvider>();
  final _ltieProvider = locator<LtieProvider>();
  final _websocketProvider = locator<WebSocketProvider>();

  Locale? locale;
  Future initialize() async {
    locale = await getLocale();

    notifyListeners();
    runStartupLogic();
    connectWS();
  }

  Future connectWS() async {
    try {
      _websocketProvider.connect();
      int id = _websocketProvider.convertStringToJson(_websocketProvider.msg);
      _websocketProvider.send(JsonMsg().subEvent(id));
      _websocketProvider.send(JsonMsg().deviceRegistry(id + 1));
    } catch (e) {
      rethrow;
    }
  }

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isAuth = await _globalAdmin.authentication();

    // This is where you can make decisions on where your app should navigate when
    // you have custom startup logic
    if (!isAuth) {
      _navigationService.replaceWithLoginView();
    } else {
      _navigationService.replaceWithHomeView();
      AppPref.setActiveLineData(await _ltieProvider.getActiveLine());
    }
    // _navigationService.replaceWithLoginView();
  }
}
