// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String LANG_CODE = "languageCode";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setString(LANG_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  String langCode = sharedPref.getString(LANG_CODE) ?? 'en';
  return _locale(langCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case 'en':
      return const Locale('en', 'KM');

    case 'km':
      return const Locale('km', 'EN');

    default:
      return const Locale('en');
  }
}

AppLocalizations translate(BuildContext context) {
  return AppLocalizations.of(context)!;
}
