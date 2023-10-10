import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;

import "../helper/helper.dart";

class LTCrudApi<T extends dynamic> extends BaseApi {
  GenericCallback<T>? fromJsonFn;

  Future<T> add(T obj) async {
    var resp = await post(route: "/", body: obj, params: {});
    var result = fromJsonFn!(resp);
    return result;
  }

  Future<T> copy(T obj) async {
    var resp = await post(route: "/copy", body: obj, params: {});
    var result = fromJsonFn!(resp);
    return result;
  }

  Future<T> update(T obj) async {
    var params = {"{id}": obj.id};
    var resp = await put(route: "/{id}", body: obj, params: params);
    var result = fromJsonFn!(resp);
    return result;
  }

  Future<T> remove(T obj) async {
    var params = {"{id}": obj.id};
    var resp = await delete(route: "/{id}", params: params);
    var result = fromJsonFn!(resp);
    return result;
  }

  Future<T> find(String id) async {
    var params = {"{id}": id};
    var resp = await get(route: "/{id}", params: params);
    var result = fromJsonFn!(resp);
    return result;
  }

  Future<List<T>> all() async {
    var resp = await get(route: "");
    var result = Paging.getList<T>(resp, fromJsonFn);
    return result;
  }

  Future<Paging<T>> filter([dynamic filter]) async {
    filter ??= FilterModel()
      ..filter = ""
      ..limit = 25
      ..page = 1
      ..sort = "";
    var params = filter.toJson();
    var resp = await get(params: params);
    var paging = Paging.fromJson<T>(resp, fromJsonFn);
    return paging;
  }

  ///
  /// Filer specific page base on search argument on first filter.
  /// Basically, use filterMore for load_more to filter
  /// without passing arguments by using existing filter args in meta.
  ///
  Future<Paging<T>> filterMeta({String? meta, num? page}) async {
    var params = {"meta": meta, "page": page};
    var resp = await get(params: params);
    var paging = Paging.fromJson<T>(resp, fromJsonFn);
    return paging;
  }
}

class BaseApi {
  String baseUrl = "";
  String resx = "";
  Map<String, String> apiHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };
  Duration timeout = const Duration(seconds: 120);

  Uri _buildUrl({String route = "", Map<String, dynamic>? params}) {
    var url = baseUrl;
    if (resx != null && resx.isNotEmpty) {
      url = url + (resx.startsWith("/") ? resx : resx);
    }
    route = route ?? "";
    if (route != null && route.isNotEmpty) {
      route = (route.startsWith("/") ? route : "/" + route);
    }
    if (params != null && params.isNotEmpty) {
      for (var entry in params.entries) {
        if (entry.key.startsWith("{")) {
          try {
            route = route.replaceAll(entry.key, entry.value);
          } catch (e) {}
        }
      }
      params.removeWhere((k, v) => k.startsWith("{"));
      params.forEach((k, v) => params[k] = v.toString());
      var uri = Uri(path: route, queryParameters: params);
      route = uri.toString();
    }

    return Uri.parse(url + route);
  }

  dynamic _parse(http.Response resp) {
    if (resp.statusCode == 200 ||
        resp.statusCode == 201 ||
        resp.statusCode == 203 ||
        resp.statusCode == 204) {
      dynamic result = json.decode(utf8.decode(resp.bodyBytes));
      return result;
    } else if (resp.statusCode == 201) {
      Exception err;
      try {
        dynamic jsn = json.decode(utf8.decode(resp.bodyBytes));
        var error = cast<ExistModel>(jsn, ExistModel.fromJson);
        err = LogicError()
          ..message = error.message
          ..url = resp.request!.url.toString()
          ..field = "error"
          ..message = error.message;
      } catch (e) {
        dynamic jsn = json.decode(utf8.decode(resp.bodyBytes));
        var error =
            cast<LTUnauthorizedError>(jsn, LTUnauthorizedError.fromJson);
        throw UnknownError()
          ..message = error.message
          ..errno = error.errno
          ..code = error.code
          ..message = error.message;
      }
      if (err != null) {
        throw err;
      }
    } else if (resp.statusCode == 400) {
      dynamic jsn = json.decode(utf8.decode(resp.bodyBytes));
      var error = cast<ErrorModel>(jsn, ErrorModel.fromJson);
      throw LogicError()
        ..message = error.message
        ..url = resp.request!.url.toString()
        ..field = error.field
        ..message = error.message;
    } else if (resp.statusCode == 401) {
      dynamic jsn = json.decode(utf8.decode(resp.bodyBytes));
      var error = cast<LTUnauthorizedError>(jsn, LTUnauthorizedError.fromJson);
      throw LTUnauthorizedError()
        ..message = error.message
        ..errno = error.errno
        ..code = error.code
        ..message = error.message;
    } else {
      dynamic jsn = json.decode(utf8.decode(resp.bodyBytes));
      var error = cast<LTUnauthorizedError>(jsn, LTUnauthorizedError.fromJson);
      throw UnknownError()
        ..message = error.message
        ..errno = error.errno
        ..code = error.code
        ..message = error.message;
    }
  }

  static dynamic toJsonable(dynamic body) {
    if (body is String) {
      return body;
    } else if (body is List) {
      var tmp = [];
      for (var item in body) {
        tmp.add(toJsonable(item));
      }
      return tmp;
    }
    return body;
  }

  static String toJson(dynamic body) {
    var jsn = toJsonable(body);
    var str = json.encode(jsn);
    return str;
  }

  T cast<T>(dynamic json, GenericCallback<T> fromJsonFn) {
    var result = fromJsonFn(json);
    return result;
  }

  Paging<T> castPage<T>(dynamic json, GenericCallback<T> fromJsonFn) {
    var result = Paging.fromJson<T>(json, fromJsonFn);
    return result;
  }

  Future<dynamic> get({String? route, Map<String, dynamic>? params}) async {
    try {
      print('apiHeaders => ${apiHeaders.toString()}');
      var url = _buildUrl(route: route ?? '', params: params);

      var resp = await http
          .get(url, headers: apiHeaders)
          .timeout(timeout, onTimeout: () => _onTimeOut(url, "get"));
      return _parse(resp);
    } catch (e) {
      _onTimeOut("throw", "get", text: "$e $route $params");
      rethrow;
    }
  }

  Future<dynamic> delete({String? route, Map<String, dynamic>? params}) async {
    try {
      var url = _buildUrl(route: route ?? '', params: params);
      var resp = await http
          .delete(url, headers: apiHeaders)
          .timeout(timeout, onTimeout: () => _onTimeOut(url, "delete"));
      return _parse(resp);
    } catch (e) {
      _onTimeOut("throw", "get", text: "$e $route $params");
      rethrow;
    }
  }

  _onTimeOut(path, routedMethodkeys, {text}) {}

  Future<dynamic> put(
      {String? route, Map<String, dynamic>? params, dynamic body}) async {
    try {
      var url = _buildUrl(route: route ?? '', params: params);
      var payload = toJson(body);
      var resp = await http
          .put(url, headers: apiHeaders, body: payload)
          .timeout(timeout, onTimeout: () => _onTimeOut(url, "put"));

      return _parse(resp);
    } catch (e) {
      _onTimeOut("throw", "get", text: "$e $route $params");
      rethrow;
    }
  }

  Future<dynamic> post(
      {required String route,
      required Map<String, dynamic> params,
      dynamic body}) async {
    var resp;
    try {
      var url = _buildUrl(route: route, params: params);
      var payload = toJson(body);
      resp = await http
          .post(url, headers: apiHeaders, body: payload)
          .timeout(timeout, onTimeout: () => _onTimeOut(url, "post"));
      return _parse(resp);
    } catch (exc) {
      _onTimeOut("throw", "get", text: "$exc $route $params");
      rethrow;
    }
  }

  Future<String> hass(
      {String? route,
      Map<String, dynamic>? params,
      String? code,
      String? clientid}) async {
    try {
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var request = http.Request('POST', Uri.parse(route!));

      request.bodyFields = {
        'grant_type': 'authorization_code',
        'code': code ?? '',
        'client_id': '$clientid/'
      };
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        return response.stream.bytesToString();
      } else {
        print(response.reasonPhrase);
      }
    } catch (exc) {
      _onTimeOut("throw", "get", text: "$exc $route $params");
      rethrow;
    }
    return "";
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
