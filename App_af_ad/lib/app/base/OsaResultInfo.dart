import 'package:syngentaaudit/app/base/BaseInfo.dart';

class OsaResultInfo extends BaseInfo {
  int workId;
  int productId;
  int osaValue;
  int layerValue;
  int footValue;
  String comment;

  OsaResultInfo({this.comment, this.osaValue,this.layerValue,this.footValue, this.productId, this.workId});

  OsaResultInfo.fromJson(dynamic json) {
    comment = json["comment"];
    productId = json["productId"];
    osaValue = json["osaValue"];
    layerValue = json["layerValue"];
    footValue = json["footValue"];
    workId = json["workId"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["comment"] = comment;
    map["productId"] = productId;
    map["osaValue"] = osaValue;
    map["layerValue"] = layerValue;
    map["footValue"] = footValue;
    //map["rowId"] = rowId;
    return map;
  }

  @override
  OsaResultInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    comment = map["comment"];
    productId = map["productId"];
    osaValue = map["osaValue"];
    layerValue = map["layerValue"];
    footValue = map["footValue"];
    workId = map["workId"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "rowId": rowId,
        "comment": comment,
        "productId": productId,
        "osaValue": osaValue,
    "layerValue": layerValue,
    "footValue": footValue,
        "workId": workId
      };
}
