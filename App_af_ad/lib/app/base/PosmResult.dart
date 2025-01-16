import 'package:syngentaaudit/app/base/BaseInfo.dart';

class PosmResultInfo extends BaseInfo {
  int workId;
  int posmId;
  int target;
  String comment;
  int value;
  int status;
  int quantity;

  PosmResultInfo(this.comment, this.posmId, this.target, this.workId,
      this.value, this.status, this.quantity);

  PosmResultInfo.fromJson(dynamic json) {
    comment = json["comment"];
    posmId = json["posmId"];
    target = json["target"];
    value = json["value"];
    workId = json["workId"];
    status = json["status"];
    quantity = json["quantity"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["comment"] = comment;
    map["posmId"] = posmId;
    map["target"] = target;
    map["value"] = value;
    map["quantity"] = quantity;
    map["status"] = status;
    //map["workId"] = workId;
    return map;
  }

  @override
  PosmResultInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    comment = map["comment"];
    posmId = map["posmId"];
    target = map["target"];
    value = map["value"];
    workId = map["workId"];
    quantity = map["quantity"];
    status = map["status"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "rowId": rowId,
        "comment": comment,
        "posmId": posmId,
        "target": target,
        "workId": workId,
        "value": value,
        "quantity": quantity,
        "status": status,
      };
}
