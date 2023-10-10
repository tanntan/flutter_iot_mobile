import 'package:flutter/material.dart';
import 'package:iot_app/app/app.dialogs.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/language_provider.dart';
import 'package:iot_app/ui/widget/radioGroup_widget.dart';
import 'package:iot_app/utils/locale_constant.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked_themes/stacked_themes.dart';

class SettingViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _languageProvider = locator<LanguageProvider>();
  final _theme = locator<ThemeService>();
  String? language;
  List<Map<String, dynamic>> radioList = [
    {'value': 'en', 'label': 'English'},
    {'value': 'km', 'label': 'ភាសារខ្មែរ'}
  ];
  Map<String, dynamic>? languageSub;
  Future<void> initialize() async {
    try {
      Locale locale = await getLocale();
      language = locale.languageCode;
      languageSub =
          radioList.firstWhere((element) => element['value'] == language);
      notifyListeners();
    } catch (e) {}
  }

  void handler(String? value) async {
    language = value!;
  }

  void languageSetting(String? title, BuildContext context) async {
    var _dialog = await _dialogService.showCustomDialog(
      variant: DialogType.newDeviceDialog,
      title: title,
      description: title,
      data: RadioGroupWidget(
        handler: handler,
        language: language,
        radioList: radioList,
      ),
    );
    _dialog?.confirmed ?? false
        ? languageChange(language, context)
        : print("Hello");
  }

  void languageChange(String? language, BuildContext context) async {
    await _languageProvider.setNewLocale(language, context);

    languageSub =
        radioList.firstWhere((element) => element['value'] == language);
    notifyListeners();
  }

  void handleThemechange() {
    _theme.toggleDarkLightTheme();
  }
}
