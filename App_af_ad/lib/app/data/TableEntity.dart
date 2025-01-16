import 'package:syngentaaudit/app/base/BaseInfo.dart';

class TableEntity extends BaseInfo {
  String name;
  String type;
  bool pk;

  TableEntity.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    name = map["name"];
    type = map["type"];
    pk = mapPK(map);
  }
  Map<String, dynamic> toMap() => {
        "rowId": rowId,
        "name": name,
        "type": type,
        "pk": isPK(),
      };

  int isPK() {
    if (pk == null) {
      return null;
    } else {
      if (pk) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  bool mapPK(Map<String, dynamic> map) {
    if (map["pk"] == null) {
      return null;
    } else {
      if (map["pk"] == 1) {
        return true;
      } else {
        return false;
      }
    }
  }
}
