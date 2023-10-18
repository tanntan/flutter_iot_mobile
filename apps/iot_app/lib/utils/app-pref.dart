// ignore_for_file: file_names

import 'dart:convert';

import 'package:iot_app/core/model/activeLine_model.dart';
import 'package:iot_app/core/model/companyInfo_model.dart';
import 'package:iot_app/core/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static SharedPreferences? _sharedPreferences;

  static Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setUserModel(UserModel value) async {
    try {
      await _sharedPreferences?.setString('userModel', json.encode(value));
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<UserModel> getUserModel() async {
    var jsonData =
        json.decode(_sharedPreferences?.getString('userModel') ?? '{}');

    UserModel user = UserModel.fromJson(jsonData);

    return user;
  }

  static Future<void> setCompanyInfo(CompanyInfoModel value) async {
    try {
      await _sharedPreferences?.setString('companyInfo', json.encode(value));
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<CompanyInfoModel> getCompanyInfo() async {
    var jsonData =
        json.decode(_sharedPreferences?.getString('companyInfo') ?? '{}');
    CompanyInfoModel companyInfoModel = CompanyInfoModel.fromJson(jsonData);

    return companyInfoModel;
  }

  static Future<Map<String, String>> apiHeader() async {
    UserModel user = await getUserModel();
    Map<String, String> apiHeaders = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${user.accessToken!}'
    };
    return apiHeaders;
  }

  static Future<bool> logout() async {
    await _sharedPreferences?.remove('userModel');
    return true;
  }

  static void setActiveLineData(ActiveLineModel model) async {
    try {
      await _sharedPreferences?.setString('activeLineData', json.encode(model));
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<ActiveLineModel> getActiveLine() async {
    var lineModel =
        json.decode(_sharedPreferences?.getString('activeLineData') ?? '{}');
    return ActiveLineModel.fromJson(lineModel);
  }

  static Future<String> getHomeAssistantUrl() async {
    CompanyInfoModel companyModel = await getCompanyInfo();
    List<String> url = companyModel.baseURL?.split('.') ?? [];
    String newUrl = '${url[0]}-hacs.${url[1]}.co';
    return newUrl;
  }
}
