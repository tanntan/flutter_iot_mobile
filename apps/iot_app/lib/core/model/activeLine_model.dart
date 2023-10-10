class ActiveLineModel {
  int? httpCode;
  int? statusCode;
  String? message;
  List<DataModel>? data;

  ActiveLineModel({
    this.httpCode,
    this.statusCode,
    this.message,
    this.data,
  });

  static ActiveLineModel fromJson(Map<String, dynamic> json) {
    return ActiveLineModel(
      httpCode: json['httpCode'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: DataModel.fromJsonList(json['data']),
    );
  }

  static List<ActiveLineModel> fromJsonList(list) {
    var data = <ActiveLineModel>[];
    for (var obj in list) {
      data.add(ActiveLineModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'httpCode': httpCode,
        'statusCode': statusCode,
        'message': message,
        'data': data,
      };

  @override
  String toString() {
    return 'ActiveLine { httpCode: $httpCode,statusCode: $statusCode,message: $message,data: $data,} ';
  }
}

class DataModel {
  int? id;
  String? lineName;
  int? factoryId;
  String? shift;

  DataModel({
    this.id,
    this.lineName,
    this.factoryId,
    this.shift,
  });

  static DataModel fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      lineName: json['lineName'],
      factoryId: json['factoryId'],
      shift: json['shift'],
    );
  }

  static List<DataModel> fromJsonList(list) {
    var data = <DataModel>[];
    for (var obj in list) {
      data.add(DataModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'lineName': lineName,
        'factoryId': factoryId,
        'shift': shift,
      };

  @override
  String toString() {
    return 'DataModel { id: $id,lineName: $lineName,factoryId: $factoryId,shift: $shift,} ';
  }
}
