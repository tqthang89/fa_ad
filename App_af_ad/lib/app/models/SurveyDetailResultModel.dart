import 'package:flutter/cupertino.dart';
import 'package:syngentaaudit/app/base/BaseInfo.dart';
import 'package:syngentaaudit/app/base/SurveyAnswerInfo.dart';

class SurveyDetailResultModel extends BaseInfo {
  int surveyId;
  int sdId;
  String name;
  String desc;
  String type;
  int imageMax;
  int imageMin;
  String comment;
  int value;
  int workId;
  int minData;
  int maxData;
  List<SurveyAnswerInfo> lstAns;
  SurveyAnswerInfo itemSelected;
  TextEditingController textController;
  String textValue;
  TextEditingController textValueController;

  SurveyDetailResultModel(
      {this.surveyId,
      this.sdId,
      this.imageMin,
      this.name,
      this.desc,
      this.type,
      this.imageMax,
      this.comment,
      this.value,
      this.workId,
      this.minData,
      this.maxData,
      this.textController,
      this.textValue,
      this.textValueController});

  SurveyDetailResultModel.fromJson(dynamic json) {
    surveyId = json["surveyId"];
    sdId = json["sdId"];
    imageMin = json["imageMin"];
    name = json["name"];
    desc = json["desc"];
    type = json["type"];
    imageMax = json["imageMax"];
    minData = json["minData"];
    maxData = json["maxData"];
    comment = json["comment"];
    value = json["value"];
    workId = json["workId"];
    textValue = json["textValue"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["surveyId"] = surveyId;
    map["sdId"] = sdId;
    map["imageMin"] = imageMin;
    map["name"] = name;
    map["desc"] = desc;
    map["type"] = type;
    map["imageMax"] = imageMax;
    map["comment"] = comment;
    map["value"] = value;
    map["workId"] = workId;
    map["minData"] = minData;
    map["maxData"] = maxData;
    map["textValue"] = textValue;
    return map;
  }

  @override
  SurveyDetailResultModel.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    surveyId = map["surveyId"];
    sdId = map["sdId"];
    imageMin = map["imageMin"];
    name = map["name"];
    desc = map["desc"];
    type = map["type"];
    imageMax = map["imageMax"];
    comment = map["comment"];
    value = map["value"];
    workId = map["workId"];
    maxData = map["maxData"];
    minData = map["minData"];
    textValue = map["textValue"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "rowId": rowId,
        "surveyId": surveyId,
        "sdId": sdId,
        "imageMin": imageMin,
        "name": name,
        "desc": desc,
        "type": type,
        "imageMax": imageMax,
        "comment": comment,
        "value": value,
        "workId": workId,
        "maxData": maxData,
        "minData": minData,
        "textValue": textValue,
      };
}
