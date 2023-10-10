class IotDeviceModel {
  String? name;
  String? lineName;
  String? remark;
  String? description;
  String? createdDate;
  String? updatedDate;
  bool? isActive;
  String? serial;
  int? stationId;
  bool? status;
  String? version;
  int? id;
  String? createdBy;
  String? updateBy;

  IotDeviceModel({
    this.name,
    this.lineName,
    this.remark,
    this.description,
    this.createdDate,
    this.updatedDate,
    this.isActive,
    this.serial,
    this.stationId,
    this.status,
    this.version,
    this.id,
    this.createdBy,
    this.updateBy,
  });

  static IotDeviceModel fromJson(Map<String, dynamic> json) {
    return IotDeviceModel(
      name: json['name'],
      lineName: json['lineName'],
      remark: json['remark'],
      description: json['description'],
      createdDate: json['created_date'],
      updatedDate: json['updated_date'],
      isActive: json['is_active'],
      serial: json['serial'],
      stationId: json['stationId'],
      status: json['status'],
      version: json['version'],
      id: json['id'],
      createdBy: json['created_by'],
      updateBy: json['update_by'],
    );
  }

  static List<IotDeviceModel> fromJsonList(list) {
    var data = <IotDeviceModel>[];
    for (var obj in list) {
      data.add(IotDeviceModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'lineName': lineName,
        'remark': remark,
        'description': description,
        'created_date': createdDate,
        'updated_date': updatedDate,
        'is_active': isActive,
        'serial': serial,
        'stationId': stationId,
        'status': status,
        'version': version,
        'id': id,
        'created_by': createdBy,
        'update_by': updateBy,
      };

  @override
  String toString() {
    return 'IotDeviceModel { name: $name,lineName: $lineName,remark: $remark,description: $description,createdDate: $createdDate,updatedDate: $updatedDate,isActive: $isActive,serial: $serial,stationId: $stationId,status: $status,version: $version,id: $id,createdBy: $createdBy,updateBy: $updateBy,} ';
  }
}
