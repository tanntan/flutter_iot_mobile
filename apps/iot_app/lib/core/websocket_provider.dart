import 'dart:async';
import 'dart:convert';

import 'package:iot_app/core/appConfig.dart';
import 'package:iot_app/core/json_str.dart';
import 'package:stacked/stacked.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider extends StreamViewModel {
  static final WebSocketProvider _singleton = WebSocketProvider._internal();
  factory WebSocketProvider() {
    return _singleton;
  }
  WebSocketProvider._internal();
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;

  String? _event;
  String? _msg;
  int? _id;

  String get msg => _msg ?? '';
  String get event => _event ?? '';

  WebSocketChannel? connect() {
    _channel = WebSocketChannel.connect(Uri.parse(AppConfig.wsAPi));
    _channel?.sink.add(JsonMsg().authWs(AppConfig.hacsToken));
    return _channel;
  }

  int convertStringToJson(String value) {
    Map jsonString = jsonDecode(value);
    print(jsonString);
    _id = jsonString['id'];
    return _id ?? 0;
  }

  void send(String message) {
    _channel?.sink.add(message);
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }

  @override
  // TODO: implement stream
  Stream<String> get stream => getEntity();

  Stream<String> getEntity() async* {
    _subscription?.cancel();
    connect()?.stream.listen((message) {
      Map json = jsonDecode(message);
      print(json);
      if (json['type'] == 'event') {
        _event = message;
      } else if (json['type'] == 'result') {
        _msg = message;
      }
    });
    yield msg;
  }
}
