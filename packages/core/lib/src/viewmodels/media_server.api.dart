import 'dart:async';
import 'dart:convert';

import 'package:core/src/helper/helper.dart';
import 'package:core/src/models/core.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class MediaServerApi {
  var url = '';
  String resx = "";
  Duration timeout = const Duration(seconds: 120);

  Uri _buildUrl({String route = "", Map<String, dynamic>? params}) {
    if (resx != null && resx.isNotEmpty) {
      url = url + (resx.startsWith("/") ? resx : "/" + resx);
    }
    route = route ?? "";
    if (route != null && route.isNotEmpty) {
      route = (route.startsWith("/") ? route : "/" + route);
    }
    if (params != null && params.isNotEmpty) {
      for (var entry in params.entries) {
        if (entry.key.startsWith("{")) {
          route = route.replaceAll(entry.key, entry.value);
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
    if (resp.statusCode == 200 || resp.statusCode == 201) {
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

  T cast<T>(dynamic json, GenericCallback<T> fromJsonFn) {
    var result = fromJsonFn(json);
    return result;
  }

  dynamic _toJsonable(dynamic body) {
    if (body is String) {
      return body;
    } else if (body is List) {
      var tmp = [];
      for (var item in body) {
        tmp.add(_toJsonable(item));
      }
      return tmp;
    } else if (body is BasedModel) {
      return body.toJson();
    }
    return body;
  }

  String toJson(dynamic body) {
    var jsn = _toJsonable(body);
    var str = json.encode(jsn);
    return str;
  }

  Future<dynamic> uploadFile(
      {@required List<http.MultipartFile>? images, payload}) async {
    try {
      Uri uri = Uri.parse(url + "file");
      dynamic result;
      http.MultipartRequest request = http.MultipartRequest("POST", uri);
      request.headers.addAll(mediaApiHeaders);
      request.fields['id'] = payload.FID.toString();
      request.fields['factory'] = payload.FACTORY;
      request.fields['defectCat'] = payload.DEFECT_CAT;
      request.fields['defect'] = payload.DEFECT;
      request.fields['seq'] = payload.SEQ;
      request.fields['createdBy'] = payload.CREATED_BY;
      images?.forEach((image) {
        request.files.add(image);
      });

      // send
      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        dynamic result = json.decode(respStr);
        return result;
      } else {
        return result;
      }
    } catch (exc) {
      rethrow;
    }
  }

  Future<dynamic> delete({@required String? imgUrl}) async {
    var params = {"url": imgUrl};

    try {
      var url = _buildUrl(route: '', params: params);
      var resp =
          await http.delete(url, headers: mediaApiHeaders).timeout(timeout);
      return _parse(resp);
    } catch (e) {
      rethrow;
    }
  }
}
