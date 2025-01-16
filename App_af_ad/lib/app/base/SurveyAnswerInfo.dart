import 'package:syngentaaudit/app/base/BaseInfo.dart';

class SurveyAnswerInfo extends BaseInfo {
  int surveyId;
  String name;
  int notCheck;
  int kpiId;
  int id;

  SurveyAnswerInfo({this.surveyId, this.id, this.name, this.notCheck});

  @override
  SurveyAnswerInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    surveyId = map["surveyId"];
    name = map["name"];
    notCheck = map["notCheck"];
    id = map["id"];
    kpiId = map["kpiId"];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "surveyId": surveyId,
        "name": name,
        "notCheck": notCheck,
        "id": id,
        "kpiId": kpiId,
      };

  SurveyAnswerInfo.fromJson(Map<String, dynamic> json) {
    rowId = json['RowId'];
    surveyId = json['surveyId'];
    name = json['name'];
    notCheck = json['notCheck'];
    id = json['id'];
    kpiId = json['kpiId'];
  }
}
