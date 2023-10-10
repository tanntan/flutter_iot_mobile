class UserModel {
  int? status;
  int? userId;
  String? username;
  int? factoryId;
  String? factory;
  String? role;
  String? language;
  String? mfgLineId;
  String? accessToken;
  String? refreshToken;

  UserModel({
    this.status,
    this.userId,
    this.username,
    this.factoryId,
    this.factory,
    this.role,
    this.language,
    this.mfgLineId,
    this.accessToken,
    this.refreshToken,
  });

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      userId: json['userId'],
      username: json['username'],
      factoryId: json['factoryId'],
      factory: json['factory'],
      role: json['role'],
      language: json['language'],
      mfgLineId: json['mfgLineId'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  static List<UserModel> fromJsonList(list) {
    var data = <UserModel>[];
    for (var obj in list) {
      data.add(UserModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'userId': userId,
        'username': username,
        'factoryId': factoryId,
        'factory': factory,
        'role': role,
        'language': language,
        'mfgLineId': mfgLineId,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  @override
  String toString() {
    return 'UserModel { status: $status,userId: $userId,username: $username,factoryId: $factoryId,factory: $factory,role: $role,language: $language,mfgLineId: $mfgLineId,accessToken: $accessToken,refreshToken: $refreshToken,} ';
  }
}
