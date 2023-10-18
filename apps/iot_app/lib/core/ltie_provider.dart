import 'package:flutter/foundation.dart';
import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/model/activeLine_model.dart';
import 'package:iot_app/services/companylogin_service.dart';
import 'package:iot_app/services/ltie_service.dart';
import 'package:stacked/stacked.dart';

class LtieProvider extends BaseViewModel {
  final _companylogin = locator<CompanyLoginService>();
  final _ltieService = locator<LtieService>();

  Future<ActiveLineModel> getActiveLine() async {
    try {
      await _companylogin.authentication();
      ActiveLineModel activeLineModel = await _ltieService.getActiveLine({});
      return activeLineModel;
    } catch (e) {
      return ActiveLineModel();
    }
  }
}
