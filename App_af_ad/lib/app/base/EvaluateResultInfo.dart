import 'package:flutter/material.dart';
import 'package:syngentaaudit/app/base/BaseInfo.dart';
import 'package:syngentaaudit/app/core/AppStyle.dart';

class EvaluateResultInfo extends BaseInfo {
  int shopId;
  String evaluateDate;
  String kpiFormatName;
  String resultName;
  int resultStatus;

  Map<String, dynamic> toMap() => <String, dynamic>{
        "RowId": rowId,
        "ShopId": shopId,
        "EvaluateDate": evaluateDate,
        "KpiFormatName": kpiFormatName,
        "ResultName": resultName,
        "ResultStatus": resultStatus,
      };

  EvaluateResultInfo.fromJson(Map<String, dynamic> json) {
    rowId = json['RowId'];
    shopId = json['ShopId'];
    evaluateDate = json['EvaluateDate'];
    kpiFormatName = json['KpiFormatName'];
    resultName = json['ResultName'];
    resultStatus = json['ResultStatus'];
  }

  @override
  EvaluateResultInfo.fromMap(Map<String, dynamic> map) {
    rowId = map['rowId'];
    shopId = map['shopId'];
    evaluateDate = map["evaluateDate"];
    kpiFormatName = map["kpiFormatName"];
    resultName = map["resultName"];
    resultStatus = map["resultStatus"];
  }
  Color getColorKPIName() {
    if (resultStatus == 0) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  Color getColorResultName() {
    if (resultStatus == 0) {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  Color getColorBackgroudResultName() {
    if (resultStatus == 0) {
      return const Color(0xFFFFE5E5);
    } else {
      return AppStyle.primary;
    }
  }
}
