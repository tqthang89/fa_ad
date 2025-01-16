import 'BaseInfo.dart';

class SurveyInfo extends BaseInfo {
  int surveyId;
  int kpiId;
  String name;
  String desc;
  String type;
  String answer1;
  String descA1;
  String type1;
  int shopFormatId;
  int imageMin;
  int imageMax;
  String photo;
  String groups;
  int surveyOrder;
  int minData;
  int maxData;

  SurveyInfo(
      {this.surveyId,
      this.kpiId,
      this.name,
      this.desc,
      this.type,
      this.answer1,
      this.descA1,
      this.type1,
      this.shopFormatId,
      this.imageMin,
      this.imageMax,
      this.photo,
      this.groups,
      this.surveyOrder,
      this.minData,
      this.maxData});

  SurveyInfo.fromJson(Map<String, dynamic> json) {
    surveyId = json['surveyId'];
    kpiId = json['kpiId'];
    name = json['name'];
    desc = json['desc'];
    type = json['type'];
    answer1 = json['answer1'];
    descA1 = json['descA1'];
    type1 = json['type1'];
    shopFormatId = json['shopFormatId'];
    imageMin = json['imageMin'];
    imageMax = json['imageMax'];
    photo = json['photo'];
    groups = json['groups'];
    surveyOrder = json['surveyOrder'];
    minData = json['minData'];
    maxData = json['maxData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surveyId'] = this.surveyId;
    data['kpiId'] = this.kpiId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['type'] = this.type;
    data['answer1'] = this.answer1;
    data['descA1'] = this.descA1;
    data['type1'] = this.type1;
    data['shopFormatId'] = this.shopFormatId;
    data['imageMin'] = this.imageMin;
    data['imageMax'] = this.imageMax;
    data['photo'] = this.photo;
    data['groups'] = this.groups;
    data['surveyOrder'] = this.surveyOrder;
    data['minData'] = this.minData;
    data['maxData'] = this.maxData;
    return data;
  }

  @override
  SurveyInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['RowId'];
    surveyId = map['surveyId'];
    kpiId = map['kpiId'];
    name = map['name'];
    desc = map['desc'];
    type = map['type'];
    answer1 = map['answer1'];
    descA1 = map['descA1'];
    type1 = map['type1'];
    shopFormatId = map['shopFormatId'];
    imageMin = map['imageMin'];
    imageMax = map['imageMax'];
    photo = map['photo'];
    groups = map['groups'];
    surveyOrder = map['surveyOrder'];
    minData = map['minData'];
    maxData = map['maxData'];
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "surveyId": surveyId,
        "kpiId": kpiId,
        "name": name,
        "desc": desc,
        "type": type,
        "answer1": answer1,
        "descA1": descA1,
        "type1": type1,
        "shopFormatId": shopFormatId,
        "imageMin": imageMin,
        "imageMax": imageMax,
        "photo": photo,
        "groups": groups,
        "surveyOrder": surveyOrder,
        "minData": minData,
        "maxData": maxData,
      };
}
