class EntitiesModel {
  String? areaId;
  String? configurationUrl;
  List? configEntries;
  List? connections;
  String? disabledBy;
  String? entryType;
  String? hwVersion;
  String? id;
  List? identifiers;
  String? manufacturer;
  String? model;
  String? nameByUser;
  String? name;
  String? swVersion;
  String? viaDeviceId;

  EntitiesModel({
    this.areaId,
    this.configurationUrl,
    this.configEntries,
    this.connections,
    this.disabledBy,
    this.entryType,
    this.hwVersion,
    this.id,
    this.identifiers,
    this.manufacturer,
    this.model,
    this.nameByUser,
    this.name,
    this.swVersion,
    this.viaDeviceId,
  });

  static EntitiesModel fromJson(Map<String, dynamic> json) {
    return EntitiesModel(
      areaId: json['area_id'],
      configurationUrl: json['configuration_url'],
      configEntries: json['config_entries'],
      connections: json['connections'],
      disabledBy: json['disabled_by'],
      entryType: json['entry_type'],
      hwVersion: json['hw_version'],
      id: json['id'],
      identifiers: json['identifiers'],
      manufacturer: json['manufacturer'],
      model: json['model'],
      nameByUser: json['name_by_user'],
      name: json['name'],
      swVersion: json['sw_version'],
      viaDeviceId: json['via_device_id'],
    );
  }

  static List<EntitiesModel> fromJsonList(list) {
    var data = <EntitiesModel>[];
    for (var obj in list) {
      data.add(EntitiesModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'area_id': areaId,
        'configuration_url': configurationUrl,
        'config_entries': configEntries,
        'connections': connections,
        'disabled_by': disabledBy,
        'entry_type': entryType,
        'hw_version': hwVersion,
        'id': id,
        'identifiers': identifiers,
        'manufacturer': manufacturer,
        'model': model,
        'name_by_user': nameByUser,
        'name': name,
        'sw_version': swVersion,
        'via_device_id': viaDeviceId,
      };

  @override
  String toString() {
    return 'EntitiesModel { areaId: $areaId,configurationUrl: $configurationUrl,configEntries: $configEntries,connections: $connections,disabledBy: $disabledBy,entryType: $entryType,hwVersion: $hwVersion,id: $id,identifiers: $identifiers,manufacturer: $manufacturer,model: $model,nameByUser: $nameByUser,name: $name,swVersion: $swVersion,viaDeviceId: $viaDeviceId,} ';
  }
}
