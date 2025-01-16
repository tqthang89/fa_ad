import 'dart:io';

import 'package:syngentaaudit/app/base/BaseInfo.dart';
import 'package:syngentaaudit/app/core/Urls.dart';

class PhotoInfo extends BaseInfo {
  String photoPath;

  String photoServer;

  String photoType;

  int workDate;

  int photoTime;

  int workId;

  int shopId;

  int kpiId;

  int itemId;

  int uploaded;

  PhotoInfo(
      {this.photoPath,
      this.photoType,
      this.workDate,
      this.photoTime,
      this.workId,
      this.shopId,
      this.kpiId,
      this.itemId,
      this.uploaded,
      this.photoServer});

  Map<String, dynamic> toMap() => {
        "rowId": rowId,
        "photoPath": photoPath,
        "photoType": photoType,
        "workDate": workDate,
        "photoTime": photoTime,
        "workId": workId,
        "shopId": shopId,
        "kpiId": kpiId,
        "itemId": itemId,
        "uploaded": uploaded,
        "photoServer": photoServer
      };

  @override
  PhotoInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    photoPath = map["photoPath"];
    photoType = map["photoType"];
    workDate = map["workDate"];
    workId = map["workId"];
    shopId = map["shopId"];
    kpiId = map["kpiId"];
    itemId = map["itemId"];
    uploaded = map["uploaded"];
    photoTime = map["photoTime"];
    photoServer = map["photoServer"];
  }

  bool mapIsUpload(Map<String, dynamic> map) {
    if (map["uploaded"] == null) {
      return null;
    } else {
      if (map["uploaded"] == 1) {
        return true;
      } else {
        return false;
      }
    }
  }

  PhotoInfo.fromJson(dynamic json) {
    rowId = json['rowId'];
    photoPath = json["photoPath"];
    photoType = json["photoType"];
    workDate = json["workDate"];
    workId = json["workId"];
    shopId = json["shopId"];
    kpiId = json["kpiId"];
    photoPath = json["photoPath"];
    itemId = json["itemId"];
    uploaded = json["uploaded"];
    photoTime = json["photoTime"];
    photoServer = json["photoServer"];
  }

  String getFileName(int employeeId) {
    File file = new File(photoPath);
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
        workDate.toString() +
        "/" +
        getFileName(employeeId);
  }
}
