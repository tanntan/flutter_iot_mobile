import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String LANG_CODE = "languageCode";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _sharedPref = await SharedPreferences.getInstance();
  await _sharedPref.setString(LANG_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _sharedPref = await SharedPreferences.getInstance();
  String langCode = _sharedPref.getString(LANG_CODE) ?? 'en';
  return _locale(langCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case 'en':
      return Locale('en', 'KM');

    case 'km':
      return Locale('km', 'EN');

    default:
      return Locale('en');
  }
}

AppLocalizations translate(BuildContext context) {
  return AppLocalizations.of(context)!;
}
