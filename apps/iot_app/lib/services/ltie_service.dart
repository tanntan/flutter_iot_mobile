import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_app/core/model/activeLine_model.dart';
import 'package:iot_app/core/model/companyInfo_model.dart';
import 'package:iot_app/utils/app-pref.dart';

class LtieService extends LTCrudApi<ActiveLineModel> {
  LtieService() {
    baseUrl = '';
    resx = "/msv/ltie/api/v1";
    fromJsonFn = ActiveLineModel.fromJson;
  }

  Future<ActiveLineModel> getActiveLine(Map<String, dynamic>? param) async {
    CompanyInfoModel companyInfoModel = await AppPref.getCompanyInfo();

    // post request to api
    baseUrl = companyInfoModel.globalBaseURL ?? '';
    apiHeaders = await AppPref.apiHeader();
    var resp =
        await get(route: "/user/lineSetup/allActiveLines", params: param ?? {});

    ActiveLineModel result = ActiveLineModel.fromJson(resp);

    return result;
  }
}
