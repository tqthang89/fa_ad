import 'package:flutter/material.dart';
import 'package:syngentaaudit/app/base/BaseInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';

class OsaResultModel extends BaseInfo {
  int productId;
  String productName;
  int shopFormatId;
  int checkprice;
  int targetOSA;
  String milkPowder;
  String keyBrand;
  String brand;
  String segment;
  String photo;
  TextEditingController textController;
  TextEditingController layyer_textController;
  TextEditingController foot_textController;
  int workId;
  int osaValue;
  int layerValue;
  int footValue;
  int footid;
  String comment;
  List<PhotoInfo> lstPhoto;
  int showKeyBrand;

  OsaResultModel(
      {this.productId,
      this.productName,
      this.shopFormatId,
      this.checkprice,
      this.targetOSA,
      this.milkPowder,
      this.keyBrand,
      this.brand,
      this.segment,
      this.photo,
      this.workId,
      this.osaValue,this.layerValue,this.footValue,this.footid,
      this.comment,this.showKeyBrand});

  OsaResultModel.fromJson(dynamic json) {
    productId = json["productId"];
    productName = json["productName"];
    shopFormatId = json["shopFormatId"];
    checkprice = json["checkprice"];
    targetOSA = json["targetOSA"];
    milkPowder = json["milkPowder"];
    keyBrand = json["keyBrand"];
    brand = json["brand"];
    segment = json["segment"];
    photo = json["photo"];
    workId = json["workId"];
    osaValue = json["osaValue"];
    layerValue = json["layerValue"];
    footValue = json["footValue"];
    footid = json["footid"];
    comment = json["comment"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["productId"] = productId;
    map["productName"] = productName;
    //map["workId"] = workId;
    map["shopFormatId"] = shopFormatId;
    map["checkprice"] = checkprice;
    map["targetOSA"] = targetOSA;
    map["milkPowder"] = milkPowder;
    map["keyBrand"] = keyBrand;
    map["brand"] = brand;
    map["segment"] = segment;
    map["photo"] = photo;
    map["osaValue"] = osaValue;
    map["layerValue"] = layerValue;
    map["footValue"] = footValue;
    map["footid"] = footid;
    map["comment"] = comment;
    return map;
  }

  @override
  OsaResultModel.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    productId = map["productId"];
    productName = map["productName"];
    shopFormatId = map["shopFormatId"];
    checkprice = map["checkprice"];
    targetOSA = map["targetOSA"];
    milkPowder = map["milkPowder"];
    keyBrand = map["keyBrand"];
    brand = map["brand"];
    segment = map["segment"];
    photo = map["photo"];
    workId = map["workId"];
    osaValue = map["osaValue"];
    layerValue = map["layerValue"];
    footValue = map["footValue"];
    footid = map["footid"];
    comment = map["comment"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "rowId": rowId,
        "productId": productId,
        //map["workId"] = workId;
        "osaValue": osaValue,
    "layerValue": layerValue,
    "footValue": footValue,
    "footid": footid,
        "comment": comment,
        "workId": workId,
      };
}
