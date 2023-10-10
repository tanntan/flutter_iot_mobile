class BasedModel {
  String? createdAt;
  String? deletedAt;
  String? updatedAt;
  String? createdBy;
  String? updateBy;
  bool? isActive;

  BasedModel({
    this.createdAt,
    this.deletedAt,
    this.updatedAt,
    this.createdBy,
    this.updateBy,
    this.isActive,
  });

  static BasedModel fromJson(Map<String, dynamic> json) {
    return BasedModel(
      createdAt: json['created_at'],
      deletedAt: json['deleted_at'],
      updatedAt: json['updated_at'],
      createdBy: json['created_by'],
      updateBy: json['update_by'],
      isActive: json['is_active'],
    );
  }

  static List<BasedModel> fromJsonList(list) {
    var data = <BasedModel>[];
    for (var obj in list) {
      data.add(BasedModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'created_at': createdAt,
        'deleted_at': deletedAt,
        'updated_at': updatedAt,
        'created_by': createdBy,
        'update_by': updateBy,
        'is_active': isActive,
      };

  @override
  String toString() {
    return 'BasedModel { createdAt: $createdAt,deletedAt: $deletedAt,updatedAt: $updatedAt,createdBy: $createdBy,updateBy: $updateBy,isActive: $isActive,} ';
  }
}
