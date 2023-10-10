class CompanyInfoModel {
  String? appName;
  String? baseURL;
  String? company;
  String? companyName;
  int? id;
  String? socketURL;
  String? globalBaseURL;

  CompanyInfoModel({
    this.appName,
    this.baseURL,
    this.company,
    this.companyName,
    this.id,
    this.socketURL,
    this.globalBaseURL,
  });

  static CompanyInfoModel fromJson(Map<String, dynamic> json) {
    return CompanyInfoModel(
      appName: json['appName'],
      baseURL: json['baseURL'],
      company: json['company'],
      companyName: json['companyName'],
      id: json['id'],
      socketURL: json['socketURL'],
      globalBaseURL: json['globalBaseURL'],
    );
  }

  static List<CompanyInfoModel> fromJsonList(list) {
    var data = <CompanyInfoModel>[];
    for (var obj in list) {
      data.add(CompanyInfoModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'appName': appName,
        'baseURL': baseURL,
        'company': company,
        'companyName': companyName,
        'id': id,
        'socketURL': socketURL,
        'globalBaseURL': globalBaseURL,
      };

  @override
  String toString() {
    return 'ComapanyLoginModel { appName: $appName,baseURL: $baseURL,company: $company,companyName: $companyName,id: $id,socketURL: $socketURL,globalBaseURL: $globalBaseURL,} ';
  }
}

class CompanyModel {
  String? companyCode;
  String? appName;

  CompanyModel({this.companyCode, this.appName});

  static CompanyModel fromJson(Map<String, dynamic> json) {
    return CompanyModel(
        companyCode: json['companyCode'], appName: json['appName']);
  }

  static List<CompanyModel> fromJsonList(list) {
    var data = <CompanyModel>[];
    for (var obj in list) {
      data.add(CompanyModel.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() =>
      {'companyCode': companyCode, 'appName': appName};

  @override
  String toString() {
    return 'LoginModel { companyCode: $companyCode,appName:$appName} ';
  }
}
