import 'package:syngentaaudit/app/base/BaseInfo.dart';

class SurveyDetailResultInfo extends BaseInfo {
  int surveyId;
  int sdId;
  int value;
  int workId;

  SurveyDetailResultInfo({
    this.surveyId,
    this.sdId,
    this.value,
    this.workId,
  });

  SurveyDetailResultInfo.fromJson(dynamic json) {
    surveyId = json["surveyId"];
    sdId = json["sdId"];
    value = json["value"];
    workId = json["workId"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["surveyId"] = surveyId;
    map["sdId"] = sdId;
    map["value"] = value;
    map["workId"] = workId;
    return map;
  }

  @override
  SurveyDetailResultInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    surveyId = map["surveyId"];
    sdId = map["sdId"];
    value = map["value"];
    workId = map["workId"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "surveyId": surveyId,
        "sdId": sdId,
        "value": value,
        "workId": workId,
      };
}
