import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:stacked/stacked.dart';

class CustomListModel extends BaseViewModel {
  List<ScanResult> devicesList = <ScanResult>[];

  void longPress(ScanResult device, List<ScanResult> getList) {
    int idx = getList.indexWhere(
      (element) => element.device.remoteId == device.device.remoteId,
    );
    print(idx);
    if (idx >= 0) {
      getList.remove(device);
    } else {
      getList.add(device);
    }
    notifyListeners();
  }
}
