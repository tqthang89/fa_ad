import 'package:syngentaaudit/app/base/BaseInfo.dart';

class PromotionResultInfo extends BaseInfo {
  int workId;
  int promotionId;
  int value;
  int value1;
  String comment;

  PromotionResultInfo(this.workId, this.promotionId, this.value, this.value1,
      this.comment);

  PromotionResultInfo.fromJson(dynamic json) {
    workId = json["workId"];
    promotionId = json["promotionId"];
    value = json["value"];
    value1 = json["value1"];
    comment = json["comment"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["workId"] = workId;
    map["promotionId"] = promotionId;
    map["value"] = value;
    map["value1"] = value1;
    map["comment"] = comment;
    //map["workId"] = workId;
    return map;
  }

  @override
  PromotionResultInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    workId = map["workId"];
    promotionId = map["promotionId"];
    value = map["value"];
    value1 = map["value1"];
    comment = map["comment"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "rowId": rowId,
        "workId": workId,
        "promotionId": promotionId,
        "value": value,
        "value1": value1,
        "comment": comment,
      };
}
