import 'package:flutter/material.dart';
import 'package:syngentaaudit/app/base/BaseInfo.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';

class PromotionResultModel extends BaseInfo {
  int shopId;
  int promotionId;
  String scheme;
  int workId;
  int value;
  int value1;
  String comment;
  List<PhotoInfo> lstPhoto;
  TextEditingController textController;

  PromotionResultModel(
      {this.shopId,
      this.comment,
      this.value,
      this.workId,
      this.value1,
      this.scheme,
      this.promotionId,
      });

  PromotionResultModel.fromJson(dynamic json) {
    comment = json["comment"];
    value = json["value"];
    workId = json["workId"];
    shopId = json["shopId"];
    scheme = json["scheme"];
    promotionId = json["promotionId"];
    value1 = json["value1"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["comment"] = comment;
    map["value"] = value;
    //map["workId"] = workId;
    map["shopId"] = shopId;
    map["scheme"] = scheme;
    map["promotionId"] = promotionId;
    map["value1"] = value1;
    return map;
  }

  @override
  PromotionResultModel.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    comment = map["comment"];
    value = map["value"];
    workId = map["workId"];
    shopId = map["shopId"];
    scheme = map["scheme"];
    promotionId = map["promotionId"];
    value1 = map["value1"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "rowId": rowId,
        "comment": comment,
        "value": value,
        "workId": workId,
        //"shopId": shopId,
        //"scheme": scheme,
        "promotionId": promotionId,
        "value1": value1,
      };
}
