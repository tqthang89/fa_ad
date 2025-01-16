import 'BaseInfo.dart';

class MasterInfo extends BaseInfo {
  String listCode;

  String code;

  int id;

  String name;

  String nameVN;

  String description;

  String refCode;

  int refId;

  int sortList;

  bool isSelected = false;

  int kpiStatus; // 0: chưa khảo sát, 1: đang làm, 2: hoàn thành.

  MasterInfo(this.listCode, this.code, this.id, this.nameVN, this.description,
      this.refCode, this.refId, this.sortList);

  Map<String, dynamic> toMap() => {
        "rowId": rowId,
        "listCode": listCode,
        "code": code,
        "id": id,
        "name": name,
        "nameVN": nameVN,
        "description": description,
        "refCode": refCode,
        "refId": refId,
        "sortList": sortList,
      };

  @override
  MasterInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    listCode = map['listCode'];
    code = map['code'];
    id = map['id'];
    nameVN = map['nameVN'];
    name = map['name'];
    description = map['description'];
    refCode = map['refCode'];
    refId = map['refId'];
    sortList = map['sortList'];
  }

  MasterInfo.fromJson(dynamic json) {
    listCode = json["listCode"];
    code = json["code"];
    id = json["id"];
    nameVN = json["nameVN"];
    name = json["name"];
    description = json["description"];
    refCode = json["refCode"];
    refId = json["refId"];
    sortList = json["sortList"];
  }
}
