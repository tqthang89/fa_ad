import 'package:syngentaaudit/app/base/BaseInfo.dart';

class WorkResultInfo extends BaseInfo {
  int shopId;
  int shopFormatId;
  int workDate;
  int auditResult;
  bool isSave;
  bool isDone;
  bool isUpload;
  String shopName;
  String shopType;
  String workTime;
  String comment;
  bool locked;

  WorkResultInfo();

  int isUploadFn() {
    if (isUpload == null) {
      return null;
    } else {
      if (isUpload) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  int isDoneFn() {
    if (isDone == null) {
      return null;
    } else {
      if (isDone) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  int isSaveFn() {
    if (isSave == null) {
      return null;
    } else {
      if (isSave) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  bool mapisUpload(Map<String, dynamic> map) {
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

  bool mapisDone(Map<String, dynamic> map) {
    if (map["isDone"] == null) {
      return null;
    } else {
      if (map["isDone"] == 1) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool mapisSave(Map<String, dynamic> map) {
    if (map["isSave"] == null) {
      return null;
    } else {
      if (map["isSave"] == 1) {
        return true;
      } else {
        return false;
      }
    }
  }

  bool mapIslocked(Map<String, dynamic> map) {
    if (map["isDone"] == null) {
      return null;
    } else {
      if (map["isDone"] == 1) {
        return true;
      } else {
        return false;
      }
    }
  }

  Map<String, dynamic> toMap() => {
        "rowId": rowId,
        "shopId": shopId,
        "workDate": workDate,
        "shopFormatId": shopFormatId,
        "workTime": workTime,
        "auditResult": auditResult,
        "shopType": shopType,
        "shopName": shopName,
        "isSave": isSaveFn(),
        "isDone": isDoneFn(),
        "isUpload": isUploadFn(),
        "comment": comment
      };

  @override
  WorkResultInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    shopId = map["shopId"];
    workDate = map["workDate"];
    shopFormatId = map["shopFormatId"];
    workTime = map["workTime"];
    auditResult = map["auditResult"];
    isUpload = mapisUpload(map);
    shopType = map["shopType"];
    shopName = map["shopName"];
    comment = map["comment"];
    isSave = mapisSave(map);
    isDone = mapisDone(map);
    locked = mapIslocked(map);
  }
}
