import 'package:flutter/material.dart';
import 'package:syngentaaudit/app/base/BaseInfo.dart';
import 'package:syngentaaudit/app/base/MasterInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';

class PosmResultModel extends BaseInfo {
  int shopId;
  int posmId;
  String posmName;
  String photo;
  int workId;
  int value;
  String comment;
  int status;
  int quantity;
  MasterInfo itemSelected;
  List<PhotoInfo> lstPhoto;
  TextEditingController textController;
  List<MasterInfo> lstAns;
  int target;

  PosmResultModel(
      {this.shopId,
      this.comment,
      this.value,
      this.workId,
      this.status,
      this.posmName,
      this.photo,
      this.quantity,
      this.posmId,
      this.target});

  PosmResultModel.fromJson(dynamic json) {
    comment = json["comment"];
    value = json["value"];
    workId = json["workId"];
    shopId = json["shopId"];
    posmName = json["posmName"];
    photo = json["photo"];
    posmId = json["posmId"];
    status = json["status"];
    quantity = json["quantity"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["comment"] = comment;
    map["value"] = value;
    //map["workId"] = workId;
    map["shopId"] = shopId;
    map["posmName"] = posmName;
    map["photo"] = photo;
    map["posmId"] = posmId;
    map["status"] = status;
    map["quantity"] = quantity;
    return map;
  }

  @override
  PosmResultModel.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    comment = map["comment"];
    value = map["value"];
    workId = map["workId"];
    shopId = map["shopId"];
    posmName = map["posmName"];
    photo = map["photo"];
    posmId = map["posmId"];
    status = map["status"];
    quantity = map["quantity"];
    target = map["target"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "rowId": rowId,
        "comment": comment,
        "value": value,
        "workId": workId,
        //"shopId": shopId,
        //"posmName": posmName,
        "posmId": posmId,
        "status": status,
        "quantity": quantity,
        "target": target,
      };
}
