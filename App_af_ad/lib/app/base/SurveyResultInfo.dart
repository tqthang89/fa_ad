import 'package:syngentaaudit/app/base/BaseInfo.dart';

class SurveyResultInfo extends BaseInfo {
  String comment;
  int surveyId;
  int value;
  int workId;
  String textValue;

  SurveyResultInfo(
      {this.comment, this.surveyId, this.value, this.textValue, this.workId});

  SurveyResultInfo.fromJson(dynamic json) {
    comment = json["comment"];
    surveyId = json["surveyId"];
    value = json["value"];
    workId = json["workId"];
    textValue = json["textValue"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["comment"] = comment;
    map["surveyId"] = surveyId;
    map["value"] = value;
    map["textValue"] = textValue;
    //map["workId"] = workId;
    return map;
  }

  @override
  SurveyResultInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    comment = map["comment"];
    surveyId = map["surveyId"];
    value = map["value"];
    textValue = map["textValue"];
    workId = map["workId"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "rowId": rowId,
        "comment": comment,
        "surveyId": surveyId,
        "value": value,
        "textValue": textValue,
        "workId": workId
      };
}
