class ParamModel {
  String? deviceName;
  String? line;
  int? station;
  String? environment;
  int? gmtOffset;
  String? mqttServer;

  ParamModel({
    this.deviceName,
    this.line,
    this.station,
    this.environment,
    this.gmtOffset,
    this.mqttServer,
  });

  static ParamModel fromJson(Map<String, dynamic> json) {
    return ParamModel(
      deviceName: json['deviceName'],
      line: json['line'],
      station: json['station'],
      environment: json['environment'],
      gmtOffset: json['gmtOffset'],
      mqttServer: json['mqttServer'],
    );
  }

  static List<ParamModel> fromJsonList(list) {
    var data = <ParamModel>[];
    for (var obj in list) {
      data.add(ParamModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'deviceName': deviceName,
        'line': line,
        'station': station,
        'environment': environment,
        'gmtOffset': gmtOffset,
        'mqttServer': mqttServer,
      };

  @override
  String toString() {
    return 'ParamModel { deviceName: $deviceName,line: $line,station: $station,environment: $environment,gmtOffset: $gmtOffset,mqttServer: $mqttServer,} ';
  }
}
