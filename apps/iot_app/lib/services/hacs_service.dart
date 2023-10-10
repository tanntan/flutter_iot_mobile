import 'package:core/core.dart';
import 'package:iot_app/core/appConfig.dart';

class HacsService extends LTCrudApi<BaseApi> {
  HacsService() {
    baseUrl = AppConfig.hassAPI;
    resx = 'api';
    apiHeaders = {
      'authorization': 'Bearer ${AppConfig.hacsToken}',
      'content-type': 'application/json'
    };
  }
  Future<dynamic> getService() async {
    var resp = await get(route: '/services', params: {});
    return resp;
  }
}
