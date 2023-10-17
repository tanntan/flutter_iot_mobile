import 'dart:convert';

class JsonMsg {
  String authWs(String token) {
    var jsonString = jsonEncode({
      "type": "auth",
      "access_token": token,
    });
    return jsonString;
  }

  String getLongLiveToken(String clientName) {
    var jsonObject = jsonEncode({
      "id": 1,
      "type": "auth/long_lived_access_token",
      "client_name": clientName,
      "client_icon": "{mdi:account}",
      "lifespan": 365
    });

    return jsonObject;
  }

  String deviceRegistry(int id) {
    var jsonObject =
        jsonEncode({"type": "config/device_registry/list", "id": id});

    return jsonObject;
  }

  String subEvent(int id) {
    var json = jsonEncode(
        {"id": id, "type": "subscribe_events", "event_type": "state_changed"});
    return json;
  }

  String configEntity(int id) {
    var json = jsonEncode({"type": "config/entity_registry/list", "id": id});
    return json;
  }

  String callServiceMsg(String entityId, String command) {
    var jsonObject = jsonEncode(
      {
        "type": "call_service",
        "domain": "light",
        "service": command,
        "service_data": {"entity_id": entityId},
        "id": 1
      },
    );
    return jsonObject;
  }

  String bluePrintLitMsg(String entityId, String command) {
    var jsonObject = jsonEncode(
      {
        "type": "call_service",
        "domain": "light",
        "service": "turn_on",
        "service_data": {"entity_id": "light.yeelink_color5_805d_light"},
        "id": 1
      },
    );
    return jsonObject;
  }
}
