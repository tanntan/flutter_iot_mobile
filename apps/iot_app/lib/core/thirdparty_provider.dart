import 'package:iot_app/services/hacs_service.dart';
import 'package:stacked/stacked.dart';

class ThirdPartyProvider extends BaseViewModel {
  List<dynamic>? services;
  final HacsService _serviceThirdParty = HacsService();

  Future<dynamic> getService() async {
    var resp = await _serviceThirdParty.getService();
    print(' Hellow  $resp');
  }
}
