class LoginModel {
  String? companyCode;
  String? username;
  String? password;

  LoginModel({this.companyCode, this.username, this.password});

  static LoginModel fromJson(Map<String, dynamic> json) {
    return LoginModel(
        companyCode: json['companyCode'],
        username: json['username'],
        password: json['password']);
  }

  static List<LoginModel> fromJsonList(list) {
    var data = <LoginModel>[];
    for (var obj in list) {
      data.add(LoginModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() =>
      {'companyCode': companyCode, 'username': username, 'password': password};

  @override
  String toString() {
    return 'LoginModel { companyCode: $companyCode,username: $username,password: $password} ';
  }
}
