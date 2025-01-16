import 'dart:io';

import 'package:syngentaaudit/app/base/BaseInfo.dart';
import 'package:syngentaaudit/app/core/Urls.dart';

class AttendantInfo extends BaseInfo {
  int shopId;
  int attendantDate;
  int attendantType;
  int attendantTime;
  double latitude;
  double longitude;
  double accuracy;
  String attendantPhoto;
  String photoServer;
  int uploaded;
  int workId;

  AttendantInfo();

  Map<String, dynamic> toMap() => {
        "RowId": rowId,
        "shopId": shopId,
        "attendantDate": attendantDate,
        "attendantType": attendantType,
        "attendantTime": attendantTime,
        "latitude": latitude,
        "longitude": longitude,
        "accuracy": accuracy,
        "attendantPhoto": attendantPhoto,
        "photoServer": photoServer,
        "uploaded": uploaded,
        "workId": workId
      };

  @override
  AttendantInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    shopId = map["shopId"];
    attendantDate = map["attendantDate"];
    attendantType = map["attendantType"];
    attendantTime = map["attendantTime"];
    latitude = map["latitude"];
    longitude = map["longitude"];
    accuracy = map["accuracy"];
    attendantPhoto = map["attendantPhoto"];
    photoServer = map["photoServer"];
    uploaded = map["uploaded"];
    workId = map["workId"];
  }

  AttendantInfo.fromJson(dynamic json) {
    rowId = json['RowId'];
    shopId = json["shopId"];
    attendantDate = json["attendantDate"];
    attendantType = json["attendantType"];
    attendantTime = json["attendantTime"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    accuracy = json["accuracy"];
    attendantPhoto = json["attendantPhoto"];
    photoServer = json["photoServer"];
    uploaded = json["uploaded"];
    workId = json["workId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["RowId"] = rowId;
    map["shopId"] = shopId;
    map["attendantDate"] = attendantDate;
    map["attendantType"] = attendantType;
    map["attendantTime"] = attendantTime;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["accuracy"] = accuracy;
    map["attendantPhoto"] = attendantPhoto;
    map["photoServer"] = photoServer;
    map["uploaded"] = uploaded;
    map["workId"] = workId;
    return map;
  }

  String getFileName(int employeeId) {
    File file = new File(attendantPhoto);
    String name = file.path.split("/").last;
    return employeeId.toString() +
        "_" +
        name
            .replaceAll(".query", ".jpeg")
            .replaceAll("-", "")
            .replaceAll(".attendant", ".jpeg")
            .replaceAll(".product", ".jpeg");
  }

  String getUrl(int employeeId) {
    return Urls.ROOT +
        "Upload/Images/" +
        attendantDate.toString() +
        "/" +
        getFileName(employeeId);
  }
}
