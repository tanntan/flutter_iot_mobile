Map<String, String> apiHeaders = {
  "Content-Type": "application/json",
  "Accept": "application/json",
  "api_key": "Joonaak@Tech2020123456789",
  "Authorization": "..."
};

typedef GenericCallback<T> = T Function(Map<String, dynamic> json);

class Paging<T extends dynamic> {
  List<T>? data = <T>[];
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Paging({
    List<T>? data,
    num? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    String? nextPageUrl,
    String? path,
    int? perPage,
    String? prevPageUrl,
    int? to,
    int? total,
  }) {
    this.data = data ?? <T>[];
    this.currentPage = currentPage! as int;
    this.firstPageUrl = firstPageUrl ?? '';
    this.from = from ?? 0;
    this.lastPage = lastPage ?? 0;
    this.lastPageUrl = lastPageUrl ?? '';
    this.nextPageUrl = nextPageUrl ?? '';
    this.path = path ?? '';
    this.perPage = perPage ?? 0;
    this.prevPageUrl = prevPageUrl ?? '';
    this.to = to ?? 0;
    this.total = total ?? 1;
  }

  Map<String, dynamic> toJson() => {
        "data": data,
        "current_page": currentPage,
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };

  static Paging<T> fromJson<T extends dynamic>(
      Map<String, dynamic> json, dynamic factory) {
    return Paging(
      data: getList<T>(json["data"], factory),
      currentPage: json['current_page'],
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }

  static T getSource<T extends dynamic>(dynamic data, dynamic factory) {
    return factory(data);
  }

  static List<T> getList<T extends dynamic>(
      List<dynamic> data, dynamic factory) {
    var items = <T>[];
    for (var item in data) {
      items.add(factory(item));
    }
    return items;
  }
}

class FilterModel {
  String? filter;
  String? filter2;
  num? limit;
  num? page;
  String? sort;
  String? providerId;
  DateTime? d1;
  DateTime? d2;
  num cache;

  FilterModel(
      {this.filter = "",
      this.filter2 = '',
      this.limit = 25,
      this.page = 1,
      this.sort = "",
      this.cache = 2000});

  static FilterModel fromJson(Map<String, dynamic> json) {
    return FilterModel(
      filter: json['filter'],
      filter2: json['filter2'],
      limit: json['limit'],
      page: json['page'],
      sort: json['sort'],
    );
  }

  Map<String, dynamic> toJson() => {
        'filter': filter,
        'filter2': filter2,
        'limit': limit,
        'page': page,
        'sort': sort,
        'cache': cache,
      };
}

class ExistModel {
  String? message;
  String? type;

  ExistModel({this.message, this.type});

  static ExistModel fromJson(Map<String, dynamic> json) {
    return ExistModel(message: json['message'], type: json['type']);
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'type': type,
      };
}

class LogicError extends RestError {
  String? field = "";

  LogicError({message = "Logic error!", this.field}) : super(message);
}

class RestError implements Exception {
  dynamic message;
  String? url;
  dynamic extraMessage;

  RestError(this.message, {this.url, this.extraMessage});
}

class UnknownError {
  int? errno;
  String? code;
  String? message;

  UnknownError({
    this.errno,
    this.code,
    this.message,
  });

  static UnknownError fromJson(Map<String, dynamic> json) {
    return UnknownError(
      errno: json['errno'],
      code: json['code'],
      message: json['message'],
    );
  }

  static List<UnknownError> fromJsonList(list) {
    var data = <UnknownError>[];
    for (var obj in list) {
      data.add(UnknownError.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'errno': errno,
        'code': code,
        'message': message,
      };

  @override
  String toString() {
    return 'UnknownError { errno: $errno,code: $code,message: $message,} ';
  }
}

class ErrorModel {
  String? type;
  String? message;
  String? field;
  String? error;
  int? statusCode;

  ErrorModel(
      {this.message, this.type, this.field, this.error, this.statusCode});

  static ErrorModel fromJson(Map<String, dynamic> json) {
    return ErrorModel(
        message: json['message'],
        type: json['type'],
        field: json['field'],
        error: json['error'],
        statusCode: json['statusCode']);
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'type': type,
        'field': field,
        'error': error,
        'statusCode': statusCode
      };
}

class NotFoundError extends RestError {
  NotFoundError([String message = "404 - Not found!"]) : super(message);
}

class InternalErrorModel {
  dynamic message;
  dynamic type;
  dynamic status;

  InternalErrorModel({this.message, this.type, this.status});

  static InternalErrorModel fromJson(Map<String, dynamic> json) {
    return InternalErrorModel(
        message: json['message'], type: json['type'], status: json['status']);
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'type': type,
        'status': status,
      };
}

class InternalServerError extends RestError {
  InternalServerError([String message = "500 - Internal Server Error!"])
      : super(message);
}

class LTError {
  int? errno;
  String? code;
  String? message;

  LTError({
    this.errno,
    this.code,
    this.message,
  });

  static LTError fromJson(Map<String, dynamic> json) {
    return LTError(
      errno: json['errno'],
      code: json['code'],
      message: json['message'],
    );
  }

  static List<LTError> fromJsonList(list) {
    var data = <LTError>[];
    for (var obj in list) {
      data.add(LTError.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'errno': errno,
        'code': code,
        'message': message,
      };

  @override
  String toString() {
    return 'LTError { errno: $errno,code: $code,message: $message,} ';
  }
}

// #GA UnauthorizedError
class LTUnauthorizedError {
  int? errno;
  String? code;
  String? message;

  LTUnauthorizedError({
    this.errno,
    this.code,
    this.message,
  });

  static LTUnauthorizedError fromJson(Map<String, dynamic> json) {
    return LTUnauthorizedError(
      errno: json['errno'],
      code: json['code'],
      message: json['message'],
    );
  }

  static List<LTUnauthorizedError> fromJsonList(list) {
    var data = <LTUnauthorizedError>[];
    for (var obj in list) {
      data.add(LTUnauthorizedError.fromJson(obj));
    }
    return data;
  }

  Map<String, dynamic> toJson() => {
        'errno': errno,
        'code': code,
        'message': message,
      };

  @override
  String toString() {
    return 'UnauthorizedError { errno: $errno,code: $code,message: $message,} ';
  }
}

Map<String, String> mediaApiHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'multipart/form-data'
};
