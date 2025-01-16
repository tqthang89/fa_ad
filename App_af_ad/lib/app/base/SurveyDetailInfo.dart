import 'package:syngentaaudit/app/base/BaseInfo.dart';

class SurveyDetailInfo extends BaseInfo {
  int surveyId;
  int sdId;
  String name;
  String desc;
  String type;
  int imageMin;
  int imageMax;

  SurveyDetailInfo(
      {this.surveyId,
      this.sdId,
      this.name,
      this.desc,
      this.type,
      this.imageMin,
      this.imageMax});

  SurveyDetailInfo.fromJson(dynamic json) {
    surveyId = json["surveyId"];
    sdId = json["sdId"];
    name = json["name"];
    desc = json["desc"];
    type = json["type"];
    imageMin = json["imageMin"];
    imageMax = json["imageMax"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["surveyId"] = surveyId;
    map["sdId"] = sdId;
    map["name"] = name;
    map["desc"] = desc;
    map["type"] = type;
    map["imageMin"] = imageMin;
    map["imageMax"] = imageMax;
    return map;
  }

  @override
  SurveyDetailInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    surveyId = map["surveyId"];
    sdId = map["sdId"];
    name = map["name"];
    desc = map["desc"];
    type = map["type"];
    imageMin = map["imageMin"];
    imageMax = map["imageMax"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "surveyId": surveyId,
        "sdId": sdId,
        "name": name,
        "desc": desc,
        "type": type,
        "imageMin": imageMin,
        "imageMax": imageMax
      };
}
