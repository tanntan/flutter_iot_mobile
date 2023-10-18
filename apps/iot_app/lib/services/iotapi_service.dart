import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_app/core/appConfig.dart';
import 'package:iot_app/core/model/companyInfo_model.dart';
import 'package:iot_app/core/model/iot_device_model.dart';
import 'package:iot_app/utils/app-pref.dart';
// import 'package:iot_app/utils/app-pref.dart';
// import 'package:iot_app/utils/app-pref.dart';

class IotapiService extends LTCrudApi<CompanyInfoModel> {
  IotapiService() {
    resx = "api/v1";
    fromJsonFn = CompanyInfoModel.fromJson;
  }

  Future<List<IotDeviceModel>> getDevice() async {
    CompanyInfoModel companyInfoModel = await AppPref.getCompanyInfo();
    baseUrl = companyInfoModel.baseURL ?? '';
    var resp = await get(route: "/devices/", params: {});
    List<IotDeviceModel> result = IotDeviceModel.fromJsonList(resp);
    return result;
  }

  Future<bool> postDevice(IotDeviceModel body) async {
    var resp = await post(route: "/devices/", body: body, params: {});
    var result = CompanyInfoModel.fromJson(resp);
    return result.id != 0;
  }

  Future<bool> updateDevice(IotDeviceModel body, int idx) async {
    // CompanyInfoModel companyInfoModel = await AppPref.getCompanyInfo();

    // post request to api
    // baseUrl = companyInfoModel.baseURL ?? '';
    var resp = await put(route: "/devices/$idx", body: body, params: {});
    // if (kDebugMode) {
    //   print('http_response======${resp.toString()}');
    // }
    var result = CompanyInfoModel.fromJson(resp);
    return result.id != 0;
  }
}
