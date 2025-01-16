import 'package:syngentaaudit/app/base/BaseInfo.dart';

class ShopInfo extends BaseInfo {
  int shopId;
  String shopName;
  String shopCode;
  String address;
  String contactName;
  String phone;
  double latitude;
  double longitude;
  String shopType;
  String supportAudit;
  String photo;
  bool locked;
  int workDate;
  bool isUpload;
  String position;
  int status;
  String wpDescription;

  ShopInfo(
      this.shopId,
      this.shopName,
      this.shopCode,
      this.address,
      this.contactName,
      this.phone,
      this.latitude,
      this.longitude,
      this.shopType,
      this.supportAudit,
      this.photo,
      this.locked,
      this.workDate,
      this.isUpload,
      this.status,
      this.wpDescription);

  ShopInfo.fromJson(dynamic json) {
    shopName = json["shopName"];
    shopId = json["shopId"];
    shopCode = json["shopCode"];
    address = json["address"];
    contactName = json["contactName"];
    phone = json["phone"];
    latitude = json["latitude"];
    longitude = json["longitude"];
    shopType = json["shopType"];
    supportAudit = json["supportAudit"];
    photo = json["photo"];
    locked = json["locked"];
    workDate = json["workDate"];
    status = json["Status"];
    wpDescription = json["WPDescription"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["shopName"] = shopName;
    map["shopId"] = shopId;
    map["address"] = address;
    map["contactName"] = contactName;
    map["phone"] = phone;
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["photo"] = photo;
    map["locked"] = locked;
    map["workDate"] = workDate;
    map["supportAudit"] = supportAudit;
    map["Status"] = status;
    map["WPDescription"] = wpDescription;
    return map;
  }

  int islocked() {
    if (locked == null) {
      return null;
    } else {
      if (locked) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  Map<String, dynamic> toMap() => {
        "RowId": rowId,
        "shopName": shopName,
        "shopId": shopId,
        "shopCode": shopCode,
        "address": address,
        "contactName": contactName,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
        "photo": photo,
        "workDate": workDate,
        "supportAudit": supportAudit,
        "Status": status,
        "WPDescription": wpDescription,
      };

  bool maplocked(Map<String, dynamic> map) {
    if (map["locked"] == null) {
      return null;
    } else {
      if (map["locked"] == 1) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool mapIsUpload(Map<String, dynamic> map) {
    if (map["isUpload"] == null) {
      return null;
    } else {
      if (map["isUpload"] == 1) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  ShopInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    shopName = map["shopName"];
    shopCode = map["shopCode"];
    shopId = map["shopId"];
    address = map["address"];
    contactName = map["contactName"];
    phone = map["phone"];
    latitude = map["latitude"];
    longitude = map["longitude"];
    photo = map["photo"];
    locked = maplocked(map);
    workDate = map["workDate"];
    supportAudit = map["supportAudit"];
    status = map["Status"];
    wpDescription = map["WPDescription"];
    isUpload = mapIsUpload(map);
  }
}
