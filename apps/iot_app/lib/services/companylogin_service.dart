import 'package:core/core.dart';
import 'package:iot_app/core/appConfig.dart';
import 'package:iot_app/core/model/companyInfo_model.dart';
import 'package:iot_app/core/model/login_model.dart';
import 'package:iot_app/core/model/user_model.dart';
import 'package:iot_app/utils/app-pref.dart';

class CompanyLoginService extends LTCrudApi<CompanyInfoModel> {
  CompanyLoginService() {
    baseUrl = AppConfig.globalAdminUrl;
    resx = "/api/v1";
    fromJsonFn = CompanyInfoModel.fromJson;
  }

  Future<CompanyInfoModel> companyLogin(CompanyModel login) async {
    // post request to api
    var resp =
        await post(route: "/mobile/companyLogin", body: login, params: {});
    var result = CompanyInfoModel.fromJson(resp);
    return result;
  }

  Future<UserModel> userLogin(LoginModel user) async {
    // post request to api
    var resp = await post(route: "/company/userlogin", body: user, params: {});
    var result = UserModel.fromJson(resp);
    return result;
  }

  Future<dynamic> getFactoryDetails() async {
    apiHeaders = await AppPref.apiHeader();
    UserModel userModel = await AppPref.getUserModel();
    // post request to api
    var resp =
        await get(route: "/ref/factories", params: {'id': userModel.factoryId});
    var result = resp;
    return result;
  }

  Future<dynamic> authentication() async {
    apiHeaders = await AppPref.apiHeader();
    var resp = await get(route: '/me');
    return resp;
  }
}
