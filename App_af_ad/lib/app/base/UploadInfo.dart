import 'package:syngentaaudit/app/base/BaseInfo.dart';

import 'UploadedItemInfo.dart';

class UploadInfo extends BaseInfo {
  int shopId;
  int workId;
  String shopName;
  int workDate;
  String workTime;
  String groupBy;
  int shopFormatId;
  int auditResult;
  String shopType;
  int totalPhoto = 0;
  int totalAudio = 0;
  int totalPhotoSuccess = 0;
  int totalAudioSuccess = 0;
  String comment;

  List<UploadedItemInfo> itemDetail;

  Map<String, dynamic> toMap() => {
        "shopId": shopId,
        "workId": workId,
        "shopName": shopName,
        "workDate": workDate,
        "workTime": workTime,
        "shopFormatId": shopFormatId,
        "auditResult": auditResult,
        "shopType": shopType,
        "comment": comment,
      };

  @override
  UploadInfo.fromMap(Map<String, dynamic> map) {
    shopId = map["shopId"];
    workId = map["workId"];
    shopName = map["shopName"];
    workDate = map["workDate"];
    workTime = map["workTime"];
    shopFormatId = map["shopFormatId"];
    auditResult = map["auditResult"];
    shopType = map["shopType"];
    comment = map["comment"];
  }
}
