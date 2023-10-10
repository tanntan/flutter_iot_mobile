import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:iot_app/core/model/companyInfo_model.dart';
import 'package:iot_app/core/model/login_model.dart';
import 'package:iot_app/core/model/user_model.dart';
import 'package:iot_app/services/companylogin_service.dart';
import 'package:iot_app/utils/app-pref.dart';
import 'package:stacked/stacked.dart';
// ignore: implementation_imports
import 'package:core/src/helper/helper.dart';
//
//https://integration.ltlabs.co/msv/global-admin/api/v1/me

class LoginProvider extends BaseViewModel {
  final CompanyLoginService _companyLoginService = CompanyLoginService();

  Future<bool> authentication() async {
    // UserModel? user = await AppPref.getUserModel();
    try {
      await _companyLoginService.authentication();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<dynamic> companyLogin(CompanyModel companyModel) async {
    try {
      CompanyInfoModel companyInfoModel =
          await _companyLoginService.companyLogin(companyModel);
      if (kDebugMode) {
        print('companyModel = $companyModel');
      }
      await AppPref.setCompanyInfo(companyInfoModel);
      return {'success': true, 'response': companyInfoModel};
    } catch (e) {
      String err = jsonEncode(e);
      return LTUnauthorizedError.fromJson(jsonDecode(err));
    }
  }

  Future<dynamic> userLogin(LoginModel model) async {
    try {
      UserModel _user = await _companyLoginService.userLogin(model);
      if (kDebugMode) {
        print('_user $_user');
      }
      await AppPref.setUserModel(_user);
      return _user;
    } catch (e) {
      if (kDebugMode) {
        print(' error ${e.toString()}');
      }
      return e;
    }
  }

  Future<dynamic> getFactory() async {
    try {
      await authentication();
      var resp = await _companyLoginService.getFactoryDetails();
      if (kDebugMode) {
        print(resp);
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
