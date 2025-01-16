import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:syngentaaudit/app/base/LoginInfo.dart';

import 'HttpResponseMessage.dart';
import 'Shared.dart';
import 'Utility.dart';

class HttpUtils {
  static Future<void> getDefaultBody(
      {@required Map<String, dynamic> body}) async {
    if (body != null) {
      LoginInfo user = await Shared.getUser();
      body['access_token'] = user.accessToken;
      body["platform"] = Utility.getPlatform();
      body["version"] = await Utility.getVersion();
    }
  }

  static Future<Response> download(
      {@required String url, Map<String, dynamic> body}) async {
    try {
      await getDefaultBody(body: body);
      return await http
          .post(Uri.parse(url),
              headers: <String, String>{
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded",
              },
              encoding: Encoding.getByName("utf-8"),
              body: body)
          .catchError((error) {
        return new Response(
            utf8.decode("Đã có lỗi xãy ra vui lòng thử lại !".runes.toList()),
            500);
      }).timeout(new Duration(seconds: 15), onTimeout: () {
        return new Response(
            "Thời gian yêu cầu quá lâu vui lòng kiểm tra Internet và thử lại.",
            408);
      });
    } catch (ex) {
      return Response(ex.toString(), 500);
    }
  }

  static Future<HttpResponseMessage> post(
      {@required String url,
      @required Map<String, dynamic> body,
      bool isLogin = false}) async {
    if (!isLogin) {
      await getDefaultBody(body: body);
    }
    HttpResponseMessage response = new HttpResponseMessage();
    try {
      var result = await http
          .post(Uri.parse(url),
              headers: <String, String>{
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded",
              },
              encoding: Encoding.getByName("utf-8"),
              body: body)
          .catchError((error) {
        return Response(utf8.decode(error.toString().runes.toList()), 500);
      }).timeout(new Duration(seconds: 20), onTimeout: () {
        return Response(
            utf8.decode(
                "Thời gian chờ quá lâu, vui lòng thử lại !".runes.toList()),
            408);
      });
      if (result.statusCode == 200) {
        var jsonData = json.decode(result.body);
        try {
          response = HttpResponseMessage.fromJson(jsonData);
        } catch (ex) {
          response.statusCode = 500;
          response.content = jsonData["Content"].toString();
        }
      } else {
        response.statusCode = result.statusCode;
        response.content = result.body;
      }

      return response;
    } catch (ex) {
      return HttpResponseMessage(statusCode: 500, content: ex.toString());
    }
  }

  static Future<HttpResponseMessage> uploadBytes(
      {@required String url,
      @required Map<String, dynamic> body,
      List<List<int>> data,
      List<String> fileKeys}) async {
    await getDefaultBody(body: body);
    HttpResponseMessage response = new HttpResponseMessage();
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      if (data != null && data.length > 0) {
        if (fileKeys != null &&
            fileKeys.length > 0 &&
            data.length == fileKeys.length) {
          for (int i = 0; i < data.length; i++) {
            for (int j = 0; j < fileKeys.length; j++) {
              if (i == j) {
                String name = fileKeys[j];
                request.files.add(http.MultipartFile.fromBytes(name, data[i],
                    filename: name));
              }
            }
          }
        } else {
          for (int i = 0; i < data.length; i++) {
            String name = "data" + i.toString();
            request.files.add(
                http.MultipartFile.fromBytes(name, data[i], filename: name));
          }
        }
      }
      for (var entry in body.entries) {
        request.fields[entry.key] =
            entry.value != null ? entry.value.toString() : '';
      }

      var result = await http.Response.fromStream(await request.send())
          .catchError((error) {
        return new Response(utf8.decode(error.toString().runes.toList()), 500);
      }).timeout(new Duration(seconds: 20), onTimeout: () {
        return Response(
            utf8.decode(
                "Thời gian chờ quá lâu, vui lòng thử lại !".runes.toList()),
            408);
      });

      if (result.statusCode != 200) {
        response.statusCode = result.statusCode;
        response.content = result.body;
      } else {
        var jsonData = json.decode(result.body);
        try {
          response = HttpResponseMessage.fromJson(jsonData);
        } catch (ex) {
          response.statusCode = 500;
          response.content = jsonData["Content"].toString();
        }
      }
      return response;
    } catch (ex) {
      return HttpResponseMessage(statusCode: 500, content: ex.toString());
    }
  }

  static Future<HttpResponseMessage> uploadBytesV2(
      {@required String url,
        @required Map<String, dynamic> body,
        Map<String, List<int> > data}) async {
    await getDefaultBody(body: body);
    HttpResponseMessage response = new HttpResponseMessage();
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      if (data != null && data.length > 0 && data.entries.length > 0) {
        for (var item in data.entries) {
              request.files.add(http.MultipartFile.fromBytes(item.key, item.value,
                  filename: item.key));
        }
      }
      for (var entry in body.entries) {
        request.fields[entry.key] =
        entry.value != null ? entry.value.toString() : '';
      }

      var result = await http.Response.fromStream(await request.send())
          .catchError((error) {
        return new Response(utf8.decode(error.toString().runes.toList()), 500);
      }).timeout(new Duration(seconds: 20), onTimeout: () {
        return Response(
            utf8.decode(
                "Thời gian chờ quá lâu, vui lòng thử lại !".runes.toList()),
            408);
      });

      if (result.statusCode != 200) {
        response.statusCode = result.statusCode;
        response.content = result.body;
      } else {
        var jsonData = json.decode(result.body);
        try {
          response = HttpResponseMessage.fromJson(jsonData);
        } catch (ex) {
          response.statusCode = 500;
          response.content = jsonData["Content"].toString();
        }
      }
      return response;
    } catch (ex) {
      return HttpResponseMessage(statusCode: 500, content: ex.toString());
    }
  }

  static Future<HttpResponseMessage> uploadFile(
      {@required String url,
      Map<String, dynamic> body,
      @required File file}) async {
    await getDefaultBody(body: body);
    HttpResponseMessage response = new HttpResponseMessage();
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(http.MultipartFile(
        'image', file.readAsBytes().asStream(), file.lengthSync(),
        filename: file.path.split("/").last));
    for (var entry in body.entries) {
      request.fields[entry.key] =
          entry.value != null ? entry.value.toString() : null;
    }
    try {
      var result = await http.Response.fromStream(await request.send())
          .catchError((error) {
        return Response(utf8.decode(error.runes.toList()), 500);
      }).timeout(new Duration(seconds: 20), onTimeout: () {
        return Response(
            utf8.decode(
                "Thời gian chờ quá lâu, vui lòng thử lại !".runes.toList()),
            408);
      });
      if (result.statusCode != 200) {
        response.content = result.statusCode;
        response.content = result.body;
      } else {
        var jsonData = json.decode(result.body);
        try {
          response = HttpResponseMessage.fromJson(jsonData);
          return response;
        } catch (ex) {
          response.statusCode = 500;
          response.content = jsonData["Content"].toString();
        }
      }
      return response;
    } catch (ex) {
      return HttpResponseMessage(statusCode: 500, content: ex.toString());
    }
  }
}
