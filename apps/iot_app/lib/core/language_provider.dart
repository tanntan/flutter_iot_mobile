import 'package:flutter/material.dart';
import 'package:iot_app/main.dart';
import 'package:iot_app/utils/locale_constant.dart';

class LanguageProvider extends ChangeNotifier {
  static final LanguageProvider _singleton = LanguageProvider._internal();
  factory LanguageProvider() {
    return _singleton;
  }

  Locale? locale;
  LanguageProvider._internal();

  Locale getLanguage() {
    return locale!;
  }

  Future<Locale> getNewLocale() async {
    Locale _locale = await getLocale();
    locale = _locale;
    notifyListeners();
    return locale!;
  }

  Future<void> setNewLocale(String? languageCode, BuildContext context) async {
    Locale? _locale = await setLocale(languageCode!);
    MainApp.setlocale(context, _locale);
    notifyListeners();
  }

  bool _busy = false;

  bool get busy => _busy;
  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
