import 'dart:convert';

import 'package:iot_app/core/appConfig.dart';
import 'package:iot_app/core/json_str.dart';
import 'package:iot_app/core/model/entities_model.dart';
import 'package:stacked/stacked.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketProvider extends BaseViewModel {
  static final WebSocketProvider _singleton = WebSocketProvider._internal();
  factory WebSocketProvider() {
    return _singleton;
  }
  WebSocketProvider._internal();

  WebSocketChannel? _channel;
  String? _msg;
  String? _event;
  int _id = 0;
  List<EntitiesModel> entities = <EntitiesModel>[];

  String get msg => _msg ?? '';
  String get event => _event ?? '';

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(AppConfig.wsAPi));
    _channel?.sink.add(JsonMsg().authWs(AppConfig.hacsToken));
    _channel?.stream.listen((message) {
      Map json = jsonDecode(message);
      _id = convertStringToJson(message);
      print(json);
      if (json['type'] == 'event') {
        _event = message;
        notifyListeners();
      } else if (json['type'] == 'result') {
        _msg = message;
        notifyListeners();
      }
    });
  }

  Future getEntity() async {
    send(JsonMsg().deviceRegistry(_id + 1));
    Map _jsonData = json.decode(_msg!);
    entities = EntitiesModel.fromJsonList(_jsonData['result']);
    entities = entities
        .where(
            (entity) => entity.disabledBy == null && entity.entryType == null)
        .toList();
    notifyListeners();
    return entities;
  }

  int convertStringToJson(String value) {
    if (value.isNotEmpty) {
      Map jsonString = json.decode(value);
      if (jsonString.containsKey('id')) {
        return jsonString['id'] + 1;
      } else {
        return 1;
      }
    } else {
      return 1;
    }
  }

  void send(String message) {
    _channel?.sink.add(message);
  }

  @override
  void dispose() {
    _channel?.sink.close();
    super.dispose();
  }
}
