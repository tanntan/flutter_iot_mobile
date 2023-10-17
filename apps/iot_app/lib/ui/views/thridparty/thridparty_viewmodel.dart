import 'dart:async';

import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/model/entities_model.dart';
import 'package:iot_app/core/websocket_provider.dart';
import 'package:stacked/stacked.dart';

class ThridpartyViewModel extends StreamViewModel<List<EntitiesModel>> {
  final _webSocketProvider = locator<WebSocketProvider>();
  bool isGridView = false;
  Future<void> initialize() async {}

  void handleGridChange() {
    isGridView = !isGridView;
    notifyListeners();
  }

  @override
  Stream<List<EntitiesModel>> get stream => getDeviceEntity();

  Stream<List<EntitiesModel>> getDeviceEntity() async* {
    List<EntitiesModel> models = _webSocketProvider.entities;
    notifyListeners();
    yield models;
  }
}
