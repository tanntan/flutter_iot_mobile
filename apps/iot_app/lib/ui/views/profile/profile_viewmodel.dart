import 'package:flutter/foundation.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/utils/app-pref.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void handleSettingMenu() {
    _navigationService.navigateTo('/setting-view');
  }

  void logoutCompany() async {
    try {
      await AppPref.logout();
      await _navigationService.pushNamedAndRemoveUntil('/startup-view');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
