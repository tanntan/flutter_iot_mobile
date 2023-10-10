import 'dart:async';

import 'package:iot_app/app/app.locator.dart';
import 'package:iot_app/core/json_str.dart';
import 'package:iot_app/core/websocket_provider.dart';
import 'package:stacked/stacked.dart';

class ThridpartyViewModel extends StreamViewModel {
  final _webSocketProvider = locator<WebSocketProvider>();

  StreamSubscription? _subscription;
  Future<void> initialize() async {
    _webSocketProvider.send(JsonMsg().entityJsonMsg(3));
  }

  @override
  void dispose() {
    _webSocketProvider.dispose();
    super.dispose();
  }

  @override
  // TODO: implement stream
  Stream get stream => getDeviceEntity();

  Stream<dynamic> getDeviceEntity() async* {
    yield _webSocketProvider.data;
  }
}
