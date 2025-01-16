import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syngentaaudit/app/base/BaseInfo.dart';
import 'package:syngentaaudit/app/base/PhotoInfo.dart';
import 'package:syngentaaudit/app/base/SurveyAnswerInfo.dart';
import 'package:syngentaaudit/app/models/SurveyDetailResultModel.dart';

class SurveyResultModel extends BaseInfo {
  int surveyId;
  String kpi;
  int kpiId;
  int imageMin;
  int photoRequest;
  int surveyOrder;
  int shopFormatId;
  String name;
  String desc;
  String type;
  int imageMax;
  String picture;
  String colorRaw;
  int haveDetail;
  String comment;
  int value;
  int workId;
  int minData;
  int maxData;
  List<SurveyAnswerInfo> lstAns;
  RxList<SurveyDetailResultModel> lstDetail;
  SurveyAnswerInfo itemSelected;
  TextEditingController textController;
  TextEditingController textValueController;
  List<PhotoInfo> lstPhoto;
  String groups;
  int fullImage;
  String textValue;

  SurveyResultModel(
      this.surveyId,
      this.kpi,
      this.kpiId,
      this.imageMin,
      this.photoRequest,
      this.surveyOrder,
      this.shopFormatId,
      this.name,
      this.desc,
      this.type,
      this.imageMax,
      this.picture,
      this.colorRaw,
      this.haveDetail,
      this.comment,
      this.value,
      this.workId,
      this.groups,
      this.fullImage,
      this.textController,
      this.textValueController,
      this.textValue);

  SurveyResultModel.fromJson(dynamic json) {
    surveyId = json["surveyId"];
    kpi = json["kpi"];
    kpiId = json["kpiId"];
    imageMin = json["imageMin"];
    photoRequest = json["photoRequest"];
    surveyOrder = json["surveyOrder"];
    shopFormatId = json["shopFormatId"];
    name = json["name"];
    desc = json["desc"];
    type = json["type"];
    imageMax = json["imageMax"];
    picture = json["picture"];
    colorRaw = json["colorRaw"];
    haveDetail = json["haveDetail"];
    comment = json["comment"];
    value = json["value"];
    workId = json["workId"];
    groups = json["groups"];
    textValue = json["textValue"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["surveyId"] = surveyId;
    map["kpi"] = kpi;
    map["kpiId"] = kpiId;
    map["imageMin"] = imageMin;
    map["photoRequest"] = photoRequest;
    map["surveyOrder"] = surveyOrder;
    map["shopFormatId"] = shopFormatId;
    map["name"] = name;
    map["desc"] = desc;
    map["type"] = type;
    map["imageMax"] = imageMax;
    map["picture"] = picture;
    map["colorRaw"] = colorRaw;
    map["haveDetail"] = haveDetail;
    map["comment"] = comment;
    map["value"] = value;
    map["workId"] = workId;
    map["minData"] = minData;
    map["maxData"] = maxData;
    map["groups"] = groups;
    map["textValue"] = textValue;
    return map;
  }

  @override
  SurveyResultModel.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    surveyId = map["surveyId"];
    kpi = map["kpi"];
    kpiId = map["kpiId"];
    imageMin = map["imageMin"];
    photoRequest = map["photoRequest"];
    surveyOrder = map["surveyOrder"];
    shopFormatId = map["shopFormatId"];
    name = map["name"];
    desc = map["desc"];
    type = map["type"];
    imageMax = map["imageMax"];
    picture = map["picture"];
    colorRaw = map["colorRaw"];
    haveDetail = map["haveDetail"];
    comment = map["comment"];
    value = map["value"];
    workId = map["workId"];
    maxData = map["maxData"];
    minData = map["minData"];
    groups = map["groups"];
    textValue = map["textValue"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "surveyId": surveyId,
        "kpi": kpi,
        "kpiId": kpiId,
        "imageMin": imageMin,
        "photoRequest": photoRequest,
        "surveyOrder": surveyOrder,
        "shopFormatId": shopFormatId,
        "name": name,
        "desc": desc,
        "type": type,
        "imageMax": imageMax,
        "picture": picture,
        "colorRaw": colorRaw,
        "haveDetail": haveDetail,
        "comment": comment,
        "value": value,
        "workId": workId,
        "maxData": maxData,
        "minData": minData,
        "groups": groups,
        "textValue": textValue
      };
}
